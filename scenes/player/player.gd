class_name Player extends Entity

@export var slow_down_factor = 0.1;

@onready var drag_line = $DragLine;

var drag_start_pos : Vector2;

func _ready():
	super._ready();

func _enter_tree() -> void:
	RoomManager.current_room.player = self;

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		drag_start_pos = get_global_mouse_position();
		drag_line.set_point_position(0, drag_start_pos)
		drag_line.visible = true
		Engine.set_time_scale(slow_down_factor);

	if Input.is_action_pressed("mouse_left"):
		drag_line.set_point_position(1, get_global_mouse_position());

	if Input.is_action_just_released("mouse_left"):
		var direction = (drag_start_pos - get_global_mouse_position()).normalized()
		var distance = drag_start_pos.distance_to(get_global_mouse_position());
		apply_central_impulse(direction * distance * 5.0);
		drag_line.visible = false
		Engine.set_time_scale(1);

func _on_collided(body : Node) -> void:
	RoomManager.current_room.camera.shake();
	if body is Entity:
		body.take_damage(damage, self)
		take_damage(body.damage, body);

func _on_died() -> void:
	get_tree().reload_current_scene();
