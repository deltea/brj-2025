extends RigidBody2D
class_name VisibleItem;


@export var radius_increase : float = 10;
@export var rotation_speed_mult = 1.0;
@export var move_speed = 100;

@onready var parent : Entity = get_parent().get_parent();
@onready var radius = (parent.diameter/2) + radius_increase;

var time_elapsed = 	0;

func _physics_process(delta: float) -> void:
	time_elapsed += delta;
	var parent_rotation = parent.get_node("AnimatedSprite2D").rotation
	
	#I can't find a better way of doing this tbh
	var global_goal_position = parent.global_position + Vector2(radius, 0).rotated(parent_rotation * rotation_speed_mult);
	rotation = parent_rotation * rotation_speed_mult ;
	
	var diff_vector = global_goal_position - global_position;
	linear_velocity = diff_vector * move_speed;


func _on_body_entered(body: Node) -> void:
	if body is Entity and not body == parent:
		apply_effect(body);

func apply_effect(body : Entity):
	pass;
