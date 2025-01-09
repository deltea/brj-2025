extends Node
class_name Modifier;

var lifetime : float;
var timer : SceneTreeTimer;
var all_ticks : int;

var timer_interval : float;
var total_intervals : int;

@onready var body : Entity = get_parent().get_parent();

func _ready() -> void:
	create_timer_recurse(timer_interval, total_intervals);

func create_timer_recurse(timer_interval : float, ticks_left : int):
	if ticks_left == 0:
		queue_free();
	timer = get_tree().create_timer(timer_interval)
	timer.connect("timeout", func(): create_timer_recurse(timer_interval, ticks_left - 1))
	tick_effect(all_ticks - ticks_left)

func tick_effect(tick_index : int):
	pass;
