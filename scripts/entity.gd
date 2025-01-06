class_name Entity extends RigidBody2D

signal collided;
signal died;

# const SPEED = 300.0;

@export var bounce_strength : float = 1.0;
@export var angular_speed : float = 0.1;
@export var init_health = 100;
@export var health : float;
@export var damage : float = 10.0;
@onready var damage_indicator_scene : PackedScene = load("res://scenes/damage_indicator.tscn");

func _ready():
	health = init_health;

func take_damage(damage : float, damaging_body : Entity, is_damaging_self : bool = false):
	var damage_indicator_instance : DamageIndicator = damage_indicator_scene.instantiate();
	if is_damaging_self == false:
		var impact_direction = (global_position - damaging_body.global_position).normalized();
		damage_indicator_instance.set_up(global_position, damage, 1, impact_direction);
	else:
		damage_indicator_instance.set_up(global_position, damage);
	add_sibling(damage_indicator_instance);
	
	health -= damage;
	if health <= 0:
		died.emit();

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += linear_velocity.length() * angular_speed * delta;

func _on_body_entered(body: Node) -> void:
	collided.emit(body);
