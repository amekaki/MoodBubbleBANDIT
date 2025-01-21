extends Camera2D
@onready var game_manage: Node = %GameManage
@onready var label: Label = $Label
@onready var status_sprite: AnimatedSprite2D = $status
@onready var player: CharacterBody2D = %Player

func _on_status_changed_signal(old_status,new_status) -> void:
	label.text = new_status
	status_sprite.play(game_manage.status_dict[new_status]["pannel_sprite"])
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manage.connect("player_status_changed", _on_status_changed_signal)  # 连接信号

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
