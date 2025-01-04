extends State
class_name EnemyIdle

@export var enemy : Enemy;
@export var move_speed = 100;
@export var see_dist: float = 250;
@export var marker_scene : PackedScene;

@onready var animated_sprite = enemy.get_node("AnimatedSprite2D");
var marker : Marker2D;

var spawn_location : Vector2;
var goal_position : Vector2; 
var radius = 100; 
var player : Player;

var time_elapsed = 0;

func Enter():
	spawn_location = enemy.global_position;
	player = get_tree().get_first_node_in_group("players");
	animated_sprite.play("Idle");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(_delta: float) -> void:
	var player_enemy_dist = enemy.global_position.distance_to(player.global_position);
	if player_enemy_dist < see_dist:
		Transitioned.emit(self, "EnemyCharge")

func Physics_Update(_delta : float):
	time_elapsed += _delta;
	
	goal_position = spawn_location + Vector2(radius,0).rotated(PI * time_elapsed);
	
	var vector_to_center = goal_position - enemy.global_position;
	vector_to_center = vector_to_center.normalized();
	enemy.apply_central_force(vector_to_center.rotated(deg_to_rad(20)) * move_speed)
