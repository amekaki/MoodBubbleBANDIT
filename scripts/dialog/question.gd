extends Label

@export var question_info = {
	"question":"选A",
	"answer":["A","B"],
	"correst":[0]
}
@onready var answer_1: RichTextLabel = $Answer1
@onready var answer_2: RichTextLabel = $Answer2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = question_info["question"]
	answer_1.text = question_info["answer"][0]
	
