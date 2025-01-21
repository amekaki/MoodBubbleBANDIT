extends Node2D
@onready var game_manage: Node = %GameManage

@export var type = "get_new_bubble"
@export var status = "happy"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	game_manage.connect("get_new_status",_on_player_get_new_status)
	game_manage.connect("player_status_changed",_on_player_player_status_change)
func _on_player_get_new_status(status_name):
	if type == "get_new_bubble":
		if status_name == status:
			visible = true
func _on_player_player_status_change(old_status,new_status):
	if type == "status_change":
		if old_status == status:
			visible = false
		if new_status == status:
			visible = true
