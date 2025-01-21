extends CanvasLayer

@onready var game_manage: Node = %GameManage

@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel

@export var score = 0
@export var total_score=6
var bubble_pannel_list
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble_pannel_list = [$happy,$angry,$sad,$fear]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for bubble_pannel in bubble_pannel_list:
		#print("hhhhhhhhhhhhhh",game_manage.status_index,game_manage.status_list.find(bubble_pannel.bubble_name))
		if bubble_pannel.bubble_name not in  game_manage.status_list:
			bubble_pannel.status = "grey"
		elif game_manage.status_list.find(bubble_pannel.bubble_name) == game_manage.status_index:
			bubble_pannel.status = "active"
		else:
			bubble_pannel.status = "unactive"
	score_label.text = "Coins: "+str(game_manage.score)+"/"+str(game_manage.total_score)
	health_label.text = "Heart: "+ str(game_manage.heart)+"/"+str(game_manage.total_heart)
		#print(bubble_pannel.status,bubble_pannel.bubble_name)
