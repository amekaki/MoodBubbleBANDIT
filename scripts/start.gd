extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	#var level1_scene = preload()  # 预加载第一关场景
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_2_button_down() -> void:
	get_tree().quit()
