extends BossSpawn
class_name FireMini;

@export var rotation_range : float = 60;
@export var collision_immunity = 0.1;
@export var threshold_diameter = 4;

var self_scene : PackedScene = load("res://scenes/enemies/Bosses/FireBoss/fire_mini.tscn");
var split_up : bool = false;

func _physics_process(delta: float) -> void:
	super._physics_process(delta);
	collision_immunity -= delta;

func _on_collided(body : Node):
	if diameter <= threshold_diameter:
		queue_free();
	elif not body is Entity and collision_immunity < 0:
		recreate_self(-deg_to_rad(rotation_range/2))
		recreate_self(deg_to_rad(rotation_range/2))
		queue_free();

func recreate_self(angle : float):
	var self_instance : FireMini = self_scene.instantiate();
	self_instance.global_position = global_position;
	self_instance.angular_velocity = angular_velocity;
	self_instance.linear_velocity = linear_velocity.rotated(PI + angle)
	self_instance.diameter = diameter / 2;
	self_instance.split_up = true;
	add_sibling(self_instance);
