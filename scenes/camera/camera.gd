class_name Camera extends Camera2D

const DIR_SHAKE_SPEED = 50;

var curr_shake_strength : float;
var shake_decay : float;
var shaking = false;

func _enter_tree() -> void:
	RoomManager.current_room.camera = self;

func _process(delta: float) -> void:
	if shaking:
		curr_shake_strength = move_toward(curr_shake_strength, 0, shake_decay * delta);
		offset = random_offset() * curr_shake_strength;

		if curr_shake_strength < 1:
			shaking = false;

	offset = offset.move_toward(Vector2(0, 0), DIR_SHAKE_SPEED * delta);

func shake(init_shake_strength : float = 3, shake_length : float = 0.2):
	curr_shake_strength = init_shake_strength;
	shake_decay = init_shake_strength / shake_length;
	shaking = true;

func dir_shake(dir: Vector2, strength: float):
	offset = dir * strength;

func random_offset() -> Vector2:
	var unit_vector = Vector2(1, 1).normalized();
	return unit_vector.rotated(randf_range(0, 2*PI));
