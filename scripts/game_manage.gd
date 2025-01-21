extends Node

var status_index = 0
var status_list = ["normal"]
#,"happy","fear","angry","sad"
var score=0
var total_score = 1
var all_status = ["normal","happy","angry","sad","fear"]
var total_heart = 20
var heart = total_heart
const status_dict = {
	"normal":{
		"speed":90,
		"jump_velocity":-200,
		"static_sprite":"normal",
		"walk_sprite":"walk_normal",
		"jump_sprite":"jump_normal",
		"pannel_sprite":"normal",
		#"damage":10
	},
	"angry":{
		"npc_name":"Blaze",
		"speed":90,
		"jump_velocity":-200,
		"static_sprite":"angry",
		"walk_sprite":"walk_angry",
		"jump_sprite":"jump_angry",
		"pannel_sprite":"angry"
	},
	"happy":{
		"npc_name":"Lumi",
		"speed":90,
		"jump_velocity":-250,
		"static_sprite":"happy",
		"walk_sprite":"walk_happy",
		"jump_sprite":"jump_happy",
		"pannel_sprite":"happy"
	},
	"sad":{
		"npc_name":"Mora",
		"speed":50,
		"jump_velocity":-150,
		"static_sprite":"sad",
		"walk_sprite":"walk_sad",
		"jump_sprite":"jump_sad",
		"pannel_sprite":"sad"
	},
	"fear":{
		"npc_name":"Shade",
		"speed":200,
		"jump_velocity":-200,
		"static_sprite":"fear",
		"walk_sprite":"walk_fear",
		"jump_sprite":"jump_fear",
		"pannel_sprite":"fear"
	}
}
var health = 100
var can_move = true
var total_health = 100
const dialog_dict ={
	"chat": [
		{
			"question": "选A",
			"answer": ["A", "B"],
			"correst": [0]
		},
		{
			"question": "选B",
			"answer": ["A", "B"],
			"correst": [1]
		}
	],
	"happy": [
		{
			"question": "The sun is shining bright today, I feel super happy! ",
			"answer": ["Hmm, I’m a bit tired, not in the mood to smile.", "Yes! I want to be as happy as you!"],
			"correst": [1]
		},
		#{
			#"question": "Look at my fiery temper, are you brave enough to handle it?",
			#"answer": ["I prefer to stay calm, don’t want trouble.", "Bring it on! I’m fired up too!"],
			#"correst": [1]
		#}
	],
	"sad": [
		#{
			#"question": "The night is so quiet, can you feel the terrifying aura around me?",
			#"answer": ["I can feel it, don’t scare me!", "I’m not scared, the moonlight is bright tonight."],
			#"correst": [0]
		#},
		{
			"question": "Sometimes life feels heavy, do you understand that?",
			"answer": ["I get it, life can be a bit depressing.", "I prefer sunny days over gloomy ones."],
			"correst": [0]
		}
	],
	"angry": [
		#{
			#"question": "The sun is shining bright today, I feel super happy! Don’t you want to feel happy too?",
			#"answer": ["Hmm, I’m a bit tired, not in the mood to smile.", "Yes! I want to be as happy as you!"],
			#"correst": [0]
		#},
		{
			"question": "Look at my fiery temper, are you brave enough to handle it?",
			"answer": ["I prefer to stay calm, don’t want trouble.", "Bring it on! I’m fired up too!"],
			"correst": [1]
		}
	],
	"fear": [
		{
			"question": "The night is so quiet, can you feel the terrifying aura around me?",
			"answer": ["I can feel it, don’t scare me!", "I’m not scared, the moonlight is bright tonight."],
			"correst": [0]
		},
		#{
			#"question": "Sometimes life feels heavy, do you understand that?",
			#"answer": ["I get it, life can be a bit depressing.", "I prefer sunny days over gloomy ones."],
			#"correst": [0]
		#}
	]
}

func _ready() -> void:
	change_to_status("normal")
signal player_status_changed(old_status,new_status)
signal score_changed(score,total_score)
signal show_dialog(status_name)
signal chose_correct_answer(status_name)
signal catch_bubble_start()
signal player_reset()
signal play_sound(sound_name)
signal get_new_status(status_name)
signal log_player_position()
# Called when the node enters the scene tree for the first time.
func set_can_move(can_move_value):
	can_move = can_move_value
func get_can_move():
	return can_move
func player_death():
	if heart>0:
		heart-=1
		emit_signal("player_reset")
	else:
		get_tree().reload_current_scene()
func shift_player_status(offset):
	var old_index = status_index
	status_index=(status_index+offset)%len(status_list)
	emit_signal("player_status_changed",status_list[old_index],status_list[status_index])
#func change_player_status_by_index(target_index):
	#var target_status_name = all_status[target_index]
	#if target_status_name not in status_list:
		#return 
	#var old_index = status_index 
	#status_index=status_list.find(target_status_name)
	#emit_signal("player_status_changed",status_list[old_index],status_list[status_index])

func change_to_status(status_name):
	if not status_name in status_list:
		return
	var old_index = status_index
	status_index=status_list.find(status_name)
	emit_signal("player_status_changed",status_list[old_index],status_list[status_index])
 
func add_player_status(status_name):
	status_list.append(status_name)
	send_log_player_position_signal()
	emit_signal("get_new_status",status_name)
func add_coin():
	score+=1
	emit_signal("score_changed",score,total_score)
	send_log_player_position_signal()
func is_status_existed(status_name):
	return status_name in status_list
func send_show_dialog_signal(status_name):
	emit_signal("show_dialog",status_name)
func send_log_player_position_signal():
	emit_signal("log_player_position")
func send_play_sound_signal(sound_name):
	emit_signal("play_sound",sound_name)
func send_catch_bubble_start_signal(status_name):
	emit_signal("catch_bubble_start",status_name)
func get_question_by_status_name(status_name,type='question'):
	#print("get chat question",status_name)
	#print(dialog_dict[status_name])
	var chat_question = dialog_dict[status_name][randi() % dialog_dict[status_name].size()]
	return chat_question
func get_npc_name_by_status_name(status_name):
	return status_dict[status_name]["npc_name"]
func send_chose_correct_answer_signal(status_name):
	emit_signal("chose_correct_answer",status_name)

	
	
	
	
