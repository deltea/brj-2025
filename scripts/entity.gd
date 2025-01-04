class_name Entity extends RigidBody2D

signal collided;
signal died;

# const SPEED = 300.0;

@export var bounce_strength : float = 1.0;
@export var angular_speed : float = 0.1;
@export var health : float = 100.0;

func take_damage(damage : float):
	health -= damage;
	if health <= 0:
		died.emit();

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += linear_velocity.length() * angular_speed * delta;

func _on_body_entered(body: Node) -> void:
	collided.emit();
