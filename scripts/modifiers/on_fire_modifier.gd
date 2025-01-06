extends Modifier;
class_name FireModifier;

func _ready():
	timer_interval = 1;
	total_intervals = 4;
	super._ready();

func tick_effect(tick_index : int):
	body.take_damage(1, body, true);
