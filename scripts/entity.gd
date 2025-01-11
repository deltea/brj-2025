class_name Entity extends RigidBody2D

signal collided;
signal died;

# const SPEED = 300.0;

@export var bounce_strength : float = 1.0;
@export var angular_speed : float = 0.1;
@export var init_health = 100;
@export var health : float;
@export var damage : float = 10.0;
@export var diamater : float = 32;

@onready var damage_indicator_scene : PackedScene = load("res://scenes/damage_indicator.tscn");
@onready var health_bar_scene : PackedScene = load("res://scenes/HUD/enemy_health_bar.tscn");

func _ready():
	_resize(diamater)
	health = init_health;

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += linear_velocity.length() * angular_speed * delta;

func take_damage(damage : float, damaging_body : Entity, is_damaging_self : bool = false):
	#Adds damage indicator
	var damage_indicator_instance : DamageIndicator = damage_indicator_scene.instantiate();
	if is_damaging_self == false:
		var impact_direction = (global_position - damaging_body.global_position).normalized();
		damage_indicator_instance.set_up(global_position, damage, 1, impact_direction);
	else:
		damage_indicator_instance.set_up(global_position, damage);
	add_sibling(damage_indicator_instance);
	
	#Adds health bar
	if not self is Player and not self.get_node("Enemy Health Bar"):
		var health_bar_instance : Node2D = health_bar_scene.instantiate();
		health_bar_instance.entity = self;
		add_child(health_bar_instance);
	
	health -= damage;
	if health <= 0:
		died.emit();

func add_item(item : VisibleItem):
	if $Items == null:
		print("No \"Items\" Node")
		return;
	var existing_items = $Items.get_children();
	for existing_item in existing_items:
		if existing_item.name == item.name:
			return;
	
	$Items.add_child(item);

func _on_body_entered(body: Node) -> void:
	collided.emit(body);

func _resize(target_size : float):
	var children = get_children();
	var sprite_node;
	var collision_node : CollisionShape2D;
	for child in children:
		if child is AnimatedSprite2D or child is Sprite2D:
			sprite_node = child;
		if child is CollisionShape2D:
			collision_node = child;
	
	if sprite_node == null:
		return 
	
	var sprite_texture : Texture2D = sprite_node.texture if sprite_node is Sprite2D else get_current_frame(sprite_node)
	if sprite_texture == null:
		return;
	
	var texture_size = sprite_texture.get_size()
	var scale_factor = target_size / texture_size.x
	scale_factor *= scale.x;
	var scale_vector = Vector2(scale_factor, scale_factor);
	sprite_node.scale *= scale_vector
	
	if collision_node:
		collision_node.scale *= scale_vector

func get_current_frame(animated_sprite : AnimatedSprite2D) -> Texture2D:
	var frameIndex: int = animated_sprite.get_frame()
	var animationName: String = animated_sprite.animation
	var spriteFrames: SpriteFrames = animated_sprite.get_sprite_frames()
	var currentTexture: Texture2D = spriteFrames.get_frame_texture(animationName, frameIndex)

	return currentTexture
