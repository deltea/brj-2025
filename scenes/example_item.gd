extends VisibleItem


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation_speed_mult = 0.2;	

func apply_effect(body : Entity):
	body.take_damage(10);
