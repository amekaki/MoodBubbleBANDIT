extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var game_manage: Node = %GameManage
@export var can_open = false
@export var is_open = false
var is_in_area = false
var interact_key = "interact"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("close")
	game_manage.connect("score_changed", _on_score_changed)

func _on_score_changed(score,total_score):
	if score >= total_score:
		can_open = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_open and Input.is_action_just_pressed(interact_key) and is_in_area:
		animated_sprite_2d.play("open")
		timer.start()
		

func _on_timer_timeout() -> void:
	is_open = true
		
func _on_body_entered(body: Node2D) -> void:
	is_in_area = true
	if is_open:
		get_tree().change_scene_to_file("res://scenes/TheEnd.tscn")
		
func _on_body_exited(body: Node2D) -> void:
	is_in_area = false
