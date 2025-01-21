extends Node
@onready var game_manage: Node = %GameManage
@onready var bubble_break: AudioStreamPlayer2D = $BubbleBreak
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var get_star: AudioStreamPlayer2D = $GetStar
@onready var power_up: AudioStreamPlayer2D = $PowerUp
@onready var climb: AudioStreamPlayer2D = $Climb

var music_dict = {
	"bubbleBreak":0,
	"explosion":1,
	"jump":2,
	"getStar":3,
	"powerUp":4,
	"climb":5,
}
var music_list
func _ready() -> void:
	music_list = [bubble_break, explosion, jump, get_star,power_up,climb]
	game_manage.connect("play_sound", _on_player_sound)
	
func _on_player_sound(sound_name):
	if sound_name in music_dict:
		music_list[music_dict[sound_name]].play()
		#print("play",sound_name)
