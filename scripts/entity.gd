extends CharacterBody2D
class_name Entity;

signal collided;
signal died;

const SPEED = 300.0

@export var bounce_strength : float = 1.0;
@export var angular_speed : float = 50.0;
@export var health : float = 100.0;

func take_damage(damage : float):
	health -= damage;
	if health <= 0:
		died.emit();

func _physics_process(delta: float) -> void:
	update_position(delta);
	
func update_position(delta : float):
	$AnimatedSprite2D.rotation += angular_speed * delta;
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * bounce_strength
		collided.emit();		
