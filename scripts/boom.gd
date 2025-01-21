extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boom_sound: AudioStreamPlayer2D = $BoomSound


@export var boom_speed:float = 50
@export var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position +=Vector2(boom_speed,0)*delta*direction
	


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if not body.is_in_group("boom_not_hurt"):
		boom_speed=0
		animated_sprite_2d.play("explore")
		boom_sound.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "explore":
		queue_free()


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if not area.is_in_group("boom_not_hurt"):
		boom_speed=0
		animated_sprite_2d.play("explore")
		boom_sound.play()
		
