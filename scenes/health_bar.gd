extends Control

@export var health_bar_intervals : float = 8;

@onready var player : Player= RoomManager.current_room.player;
@onready var health_bar_content: Sprite = $Health
@onready var init_bar_position = health_bar_content.position;
@onready var health_bar_size = health_bar_content.texture.get_size();

var health_percentage = 1;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health_percentage = player.health/player.init_health;
	
	var clamped_percentage = clamp_to_interval(health_percentage, 1/health_bar_intervals);
	health_bar_content.target_scale = Vector2(clamped_percentage, 1)
	print((1-clamped_percentage))
	health_bar_content.position.x = init_bar_position.x - ((1-clamped_percentage) * health_bar_size.x/2)

func clamp_to_interval(num : float, interval_length : float) -> float:
	return floor(num / interval_length) * interval_length;
