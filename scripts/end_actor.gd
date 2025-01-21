extends CharacterBody2D

@export var animator : AnimatedSprite2D
@export var state : String = "angry"
@export var fear_speed : float = 60
@export var happy_speed : float = 60
# Called when the node enters the scene tree for the first time.
@onready var exit: Button = $"../Exit"
@onready var restart: Button = $"../Restart"

func _ready() -> void:
	exit.visible = false
	restart.visible = false
	play_end()
	
	
	
func play_end() -> void:
	position = Vector2(0,0)
	animator.play('development');
	await get_tree().create_timer(2).timeout
	animator.play('development_hold')
	await get_tree().create_timer(1).timeout
	state="fear"
	position = Vector2(40,16)
	animator.play('artwork')
	await get_tree().create_timer(1).timeout
	state="stand"
	await get_tree().create_timer(2).timeout
	state="happy"
	animator.play('design')
	position = Vector2(0,60)
	await get_tree().create_timer(1).timeout
	state="stand"
	await get_tree().create_timer(2).timeout
	position = Vector2(0,0)
	state="sad"
	animator.play('music')
	await get_tree().create_timer(2).timeout
	position = Vector2(-23,3)
	animator.play('thanks')
	exit.visible = true
	restart.visible = true

func _physics_process(delta: float) -> void:
	if state == "fear":
		position -= Vector2(fear_speed,0) * delta
	if state == "happy":
		position -= Vector2(randf_range(-5,5),happy_speed) * delta

	
	
