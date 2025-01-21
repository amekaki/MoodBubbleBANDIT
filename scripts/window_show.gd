extends CanvasLayer


@onready var game_manage: Node = %GameManage
@onready var dialog_background: AnimatedSprite2D = $Background
@onready var question_label: Label = $Question
@onready var answer_1: RichTextLabel = $Answer1

@onready var timer: Timer = $Timer

@onready var npc_name: Label = $NPCName
@export var curr_npc_name = "happy"
@export var question_info = {
	"question":"选A",
	"answer":["A","B"],
	"correst":[0]
}
var answer_label_list
var correct=0
var curr_choise:int = 0
var enter_press = "enter"
var up_press = "up"
var down_press = "down"
func _ready() -> void:
	game_manage.connect("show_dialog", _on_show_dialog)
	visible = false
	answer_label_list = [$Answer1,$Answer2]
func _on_show_dialog(status_name):
	visible = true
	curr_choise=0
	curr_npc_name = status_name
	question_info = game_manage.get_question_by_status_name(status_name)
	_show_dialog(status_name,question_info)
func _show_dialog(status_name,question_info):
	question_label.text = question_info["question"]
	dialog_background.play(curr_npc_name)
	correct = question_info["correst"][0]
	game_manage.set_can_move(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if visible:
		#print("check")
		if Input.is_action_just_pressed(enter_press):
			_check_answer(curr_choise)
		if Input.is_action_just_pressed(up_press) or Input.is_action_just_pressed(down_press):
			curr_choise=(curr_choise+1)%len(answer_label_list)
		for index in range(answer_label_list.size()):
			var text_code = "[b]-"+question_info["answer"][index]+"[/b]"
			if index == curr_choise:
				text_code = "[u]"+text_code+"[/u]"
			answer_label_list[index].text = text_code
func _check_answer(answer):
	if answer == correct:
		game_manage.send_chose_correct_answer_signal(curr_npc_name)
	timer.start()
	
func _on_timer_timeout() -> void:
	visible = false
	game_manage.set_can_move(true)
