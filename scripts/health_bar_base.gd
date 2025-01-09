extends Node2D

signal HealthChanged;

@export var health_bar_intervals : float = 8;

var entity : Entity;
@onready var health_bar_content: Sprite = $Health
@onready var init_bar_position = health_bar_content.position;
@onready var health_bar_size = health_bar_content.texture.get_size();

var health_percentage = 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_health_percentage = entity.health/entity.init_health
	if new_health_percentage != health_percentage:
		HealthChanged.emit()
	health_percentage = new_health_percentage;
	
	var clamped_percentage = clamp_to_interval(health_percentage, 1/health_bar_intervals);
	health_bar_content.target_scale = Vector2(clamped_percentage, 1)
	#I am sure there is a better way of doing this, clamping the health bar to the left. 
	health_bar_content.position.x = init_bar_position.x - ((1-clamped_percentage) * health_bar_size.x/2)

func clamp_to_interval(num : float, interval_length : float) -> float:
	return floor(num / interval_length) * interval_length;
