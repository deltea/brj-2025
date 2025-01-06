extends RigidBody2D
class_name VisibleItem;

@onready var parent : RigidBody2D = get_parent();
@export var radius : float = 10;
@export var rotation_speed_mult = 1;
@export var move_speed = 1;

var time_elapsed = 	0;

func _physics_process(delta: float) -> void:
	time_elapsed += delta;
	var parent_rotation = parent.get_node("AnimatedSprite2D").rotation
	var global_goal_position = parent.global_position + Vector2(radius, 0).rotated(parent_rotation);
	print(parent)
	var diff_vector = global_goal_position - global_position;
	linear_velocity = diff_vector * move_speed;


func _on_body_entered(body: Node) -> void:
	if body is Entity and not body == parent:
		apply_effect(body);

func apply_effect(body : Entity):
	pass;
