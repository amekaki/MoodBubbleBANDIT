extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var audio_player = get_node("AudioPlayer")
	audio_player.play()

		## 先加载新场景
	#var new_scene = load("res://scenes/TheEnd.tscn")
	## 然后切换
	#get_tree().change_scene_to(new_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
