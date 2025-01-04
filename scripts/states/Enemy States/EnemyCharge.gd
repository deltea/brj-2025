extends State
class_name EnemyCharge

@export var enemy : Enemy;
@export var stop_radius : float = 25;
@export var forget_dist: float = 200;

var player : RigidBody2D;
@onready var animated_sprite = enemy.get_node("AnimatedSprite2D");
@onready var move_speed = 120;

func Enter():
	print("Going to Charge")
	player = RoomManager.current_room.player;

func Physics_Update(_delta : float) -> void:
	var direction = player.global_position - enemy.global_position;
	if direction.length() > stop_radius:
		if direction.length() > forget_dist:
			Transitioned.emit(self, "EnemyIdle")
			return;
		direction = direction.normalized();
		enemy.linear_velocity = enemy.linear_velocity.move_toward(direction * move_speed, 1);
	else:
		enemy.linear_velocity = enemy.linear_velocity.move_toward(Vector2.ZERO, 10);
		
