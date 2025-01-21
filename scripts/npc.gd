extends Area2D
@onready var hint: Label = $Hint
@onready var game_manage: Node = %GameManage
var interact_key = "interact"
@export var status_type = "happy"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var npc_status = "stand" # ["stand","bubble"]
## Called when the node enters the scene tree for the first time.
var is_player_in_range = false
func _ready() -> void:
	animated_sprite_2d.play(status_type)
	game_manage.connect("chose_correct_answer", _on_chose_correct_answer)
func _process(delta):
	show_hint()
	if is_player_in_range:
		if Input.is_action_just_pressed(interact_key):
			if npc_status == "stand":
				game_manage.send_show_dialog_signal(status_type)
			elif npc_status == "bubble":
				game_manage.add_player_status(status_type)
				game_manage.send_catch_bubble_start_signal(status_type)
				npc_status = "stand"
				animated_sprite_2d.play(status_type+"_give")
		
func show_hint():
	if not is_player_in_range or game_manage.is_status_existed(status_type):
		hint.text =""
		return 
	if npc_status == "stand":
		hint.text  = "Press E to talk"
	elif npc_status == "bubble":
		hint.text  = "Press E to steal the bubble"
		
		
func _on_chose_correct_answer(status_name):
	if status_name == status_type and not game_manage.is_status_existed(status_type):
		npc_status = "bubble"
		animated_sprite_2d.play(status_type+"_bubble")
		
func _on_body_entered(body: Node2D) -> void:
	#print("enter")
	if body.is_in_group("player"):
		#print("enter",status_type)
		is_player_in_range = true
		
		#if status_type in game_manage.status_list:
			#return
		#game_manage.add_player_status(status_type)
		#print(game_manage.status_list)
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		#print("enter",status_type)
		is_player_in_range = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if "give" in animated_sprite_2d.animation:
		animated_sprite_2d.play(status_type)
