extends State;
class_name BossPitThrow;

@export var boss : Entity;
@export var fire_pit_scene : PackedScene;
@export var max_throw_length : float = 200;
@export var wall_offset = 100.0;

@onready var space_state = boss.get_world_2d().direct_space_state

func Enter():
	var fire_pit_instance = fire_pit_scene.instantiate();
	fire_pit_instance.global_position = boss.global_position;
	boss.add_sibling(fire_pit_instance);
	
	var tween_to_global = get_position();
	var tween = get_tree().create_tween();
	
	var fire_pit_collider = fire_pit_instance.get_node("CollisionShape2D");
	fire_pit_collider.disabled = true;
	tween.tween_property(fire_pit_instance, "global_position", tween_to_global, 1);
	tween.tween_property(fire_pit_collider, "disabled", false, 0);
	tween.tween_callback(transition_to_idle);

func get_position() -> Vector2:
	var dir = Vector2.UP.rotated(randf_range(0, 2 * PI));
	
	# use global coordinates, not local to node
	var max_throw_coords = boss.global_position + (dir * max_throw_length);
	var query = PhysicsRayQueryParameters2D.create(boss.global_position, max_throw_coords)
	var result = space_state.intersect_ray(query)
	
	var position : Vector2;
	if result: 
		position = result.position;
	else:
		position = max_throw_coords
	var progress = randf_range(0.4,1);
	
	print(progress)
	
	var actual_position = (boss.global_position * (1-progress)) + (position * progress);
	return actual_position;

func transition_to_idle():
	print("Transferring")
	Transitioned.emit(self, "firebossstill");
