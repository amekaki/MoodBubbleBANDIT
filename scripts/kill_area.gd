extends Area2D

@onready var game_manage: Node = %GameManage

func _on_body_entered(body: Node2D) -> void:
	game_manage.player_death()
	
