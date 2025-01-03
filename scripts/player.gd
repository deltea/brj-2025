extends Entity

@export var slow_down_factor = 0.3;
@export var speed_factor = 1;

@onready var drag_line = $"Dragging Back";
@onready var camera = $Camera2D

var dragging = false;


func _physics_process(delta: float) -> void:
	#Please tell me if there is a better way of doing this
	#Calling the Entity's _phyisics_process function
	call("_physics_process", delta)

func _process(delta: float) -> void:
	if dragging:
		Engine.set_time_scale(slow_down_factor);

func _on_main_released() -> void:
	velocity = velocity.move_toward(get_line_length(drag_line).rotated(deg_to_rad(180)), 200);
	Engine.set_time_scale(1)

func get_line_length(line : Line2D) -> Vector2:
	#Not taking mouse position because, might not want linear relationship. (I.e. harder to pull)
	return line.get_point_position(1);

func _on_collided() -> void:
	camera.shake();
