extends Node
@onready var game_manage: Node = %GameManage

var music_list
var music_dict = {
	"normal":0,
	"sad":1,
	"happy":2,
	"angry":3,
	"fear":4
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manage.connect("player_status_changed", _on_status_changed)
	music_list = [$background, $sad, $happy, $angry, $fear]
	music_list[0].play()

func _on_status_changed(old_status,new_status):
	if old_status==new_status:
		return
	for music in music_list:
		music.playing = false
	music_list[music_dict[new_status]].play()
	print("play",new_status)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
