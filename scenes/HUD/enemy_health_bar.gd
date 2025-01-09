extends "res://scripts/health_bar_base.gd"

var fade_out_time = 1;

@onready var disappear_timer: Timer = $"Disappear Timer"
@onready var parent = get_parent();

@onready var health_bar_tot_size = $HealthBarContainer.texture.get_size() * $HealthBarContainer.get_scale();
@onready var offset = Vector2(-health_bar_tot_size.x/2, 0);
@export var offset_offset : Vector2;

var tween : Tween;

func _process(delta):
	super._process(delta);
	rotation = -parent.rotation
	global_position = parent.global_position + offset + offset_offset

func _on_disappear_timer_timeout() -> void:
	tween = get_tree().create_tween();
	tween.tween_property(self, "modulate:a", 0, fade_out_time)
	tween.tween_callback(queue_free)


func _on_health_changed() -> void:
	#Stop the fading
	if tween:
		tween.stop();
		modulate.a = 1;
	
	#Restart the timer
	disappear_timer.start();
