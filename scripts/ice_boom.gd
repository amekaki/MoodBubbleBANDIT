extends Area2D

@export var boom_speed:float = 50
@export var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position +=Vector2(boom_speed,0)*delta*direction
