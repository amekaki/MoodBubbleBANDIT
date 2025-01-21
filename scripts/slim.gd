extends Area2D
@export var speed:float = 30
var direction = 1
@onready var game_manage: Node = %GameManage
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

func _process(delta: float) -> void:
	position.x += direction*speed*delta
	if ray_cast_right.is_colliding():
		direction=-1
	if ray_cast_left.is_colliding():
		direction=1
func _on_body_entered(body: Node2D) -> void:
	game_manage.player_death()
#func _on_body_entered(body: Node2D) -> void:
	#get_tree().reload_current_scene()
	
