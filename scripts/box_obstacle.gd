extends Area2D

#@export var push_force : float = 200
# Called when the node enters the scene tree for the first time.
@onready var game_manage: Node = %GameManage

func _ready() -> void:
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("boom")
	if area.is_in_group("Boom"):
		#area.queue_free()
		queue_free()
func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
