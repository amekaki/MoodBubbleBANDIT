extends Area2D

@onready var game_manage: Node = %GameManage

func _on_body_entered(body: Node2D) -> void:
	game_manage.send_play_sound_signal("getStar")
	game_manage.add_coin()
	queue_free()
