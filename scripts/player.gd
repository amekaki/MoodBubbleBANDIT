extends CharacterBody2D

@onready var player_animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manage: Node = %GameManage
@export var boom_scene:PackedScene
@export var is_hide = false
@onready var ladder_ray_cast: RayCast2D = $LadderRayCast

@onready var climb_sound: AudioStreamPlayer2D = $PlayerSoundEffects/ClimbSound
@onready var jump_sound: AudioStreamPlayer2D = $PlayerSoundEffects/JumpSound
@onready var fire_boom_sound: AudioStreamPlayer2D = $PlayerSoundEffects/FireBoomSound

var speed = 300.0
var jump_velocity = -400.0
var direction = 1
var status_info ={}
var current_status = "normal"
var catch_animate = "catch"
var is_caching = false
var last_position
var jump_press = "jump"
var right_press = "right"
var left_press = "left"
var up_press = "up"
var down_press = "down"
var shift_status_left_press = "shift_status_left"
var shift_status_right_press = "shift_status_right"
var skill_press = "skill"
var status_press_pre = "select_"
func _ready():
	last_position = position
	game_manage.connect("player_reset", _on_player_reset)
	game_manage.connect("catch_bubble_start", _on_catch_bubble_start)
	game_manage.connect("player_status_changed", _on_status_changed)
	game_manage.connect("log_player_position",_on_log_player_position)
	set_player_by_status(current_status)
func _on_player_reset():
	position = last_position
func _on_catch_bubble_start(status_name):
	player_animated_sprite.play(catch_animate)
	game_manage.send_play_sound_signal("bubbleBreak")
	is_caching = true
func _on_status_changed(old_status,new_status):
	current_status = new_status
	set_player_by_status(new_status)

func set_player_by_status(status_key):
	status_info = game_manage.status_dict[status_key]
	speed = status_info["speed"]
	jump_velocity = status_info["jump_velocity"]
	player_animated_sprite.play(status_info["static_sprite"])

func is_movable():
	return not is_hide and not is_caching
func is_on_ladder():
	return ladder_ray_cast.get_collider()
func __movement(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed(jump_press) and is_on_floor():
		velocity.y = jump_velocity
		if current_status=="happy":
			game_manage.send_play_sound_signal("jump")
		
	var curr_direction := Input.get_axis(left_press, right_press)
	if curr_direction:
		direction = curr_direction
		velocity.x = direction * speed
		player_animated_sprite.flip_h=curr_direction<0
	else:
		velocity.x = 0
func _climb_ladder(delta: float):
	var climb_direction:=Vector2.ZERO
	climb_direction.x = Input.get_axis(left_press, right_press)
	climb_direction.y = Input.get_axis(up_press, down_press)
	if climb_direction:
		velocity = climb_direction*speed/2
		if climb_direction.y:
			game_manage.send_play_sound_signal("climb")
	else:
		velocity = Vector2.ZERO
	#velocity = Vector2.ZERO
	#var x_direction := Input.get_axis(left_press, right_press)
func _physics_process(delta: float) -> void:
	if not game_manage.get_can_move():
		return
	if is_movable():
		## 移动
		if is_on_ladder(): _climb_ladder(delta)
		else: __movement(delta)
		move_and_slide()
		
		## 切换状态
		if Input.is_action_just_pressed(shift_status_left_press):
			game_manage.shift_player_status(-1)
		if Input.is_action_just_pressed(shift_status_right_press):
			game_manage.shift_player_status(1)
		for status_name in game_manage.all_status:
			if Input.is_action_just_pressed(status_press_pre+status_name):
				game_manage.change_to_status(status_name)
		## show sprite
		if Input.is_action_just_pressed(jump_press) or not is_on_floor():
			if is_on_ladder():
				player_animated_sprite.play("climb_"+current_status)
			else:
				player_animated_sprite.play(status_info["jump_sprite"])
		elif direction!=0:
			player_animated_sprite.play(status_info["walk_sprite"])
		else:
			player_animated_sprite.play(status_info["static_sprite"])	


	
	if Input.is_action_just_pressed(skill_press):
		if game_manage.status_list[game_manage.status_index]=="angry":
			var boom_node = boom_scene.instantiate()
			get_tree().current_scene.add_child(boom_node)
			boom_node.position.x = position.x
			boom_node.position.y = position.y-10
			boom_node.direction = direction
			game_manage.send_play_sound_signal("powerUp")
		if game_manage.status_list[game_manage.status_index]=="sad":
			if is_hide:
				is_hide = false
				expose_player()
			else:
				is_hide = true	
				hide_player()

func hide_player():
	player_animated_sprite.play("hide")
	collision_layer=4
func expose_player():
	player_animated_sprite.play("sad")
	collision_layer=2	


func _on_animated_sprite_2d_animation_finished() -> void:
	#print(player_animated_sprite.animation)
	if player_animated_sprite.animation == "catch":
		is_caching = false
		#print("end")


func _on_log_player_position() -> void:
	last_position = position
	#print(position)
