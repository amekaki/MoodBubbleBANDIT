extends Area2D

@export var bubble_name = "happy"
@export var status ="grey"
@onready var background: AnimatedSprite2D = $background

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if status=="grey":
		background.play(status)
		$Label.text = ""
	else :
		background.play((status)+"_"+bubble_name)
		$Label.text = bubble_name
	
