extends State
class_name FireBossMinisLaunch;

@export var boss : Entity;
@export var mini_fire_blades : PackedScene;
@export var amount_of_minis = 4;
@export var range = 120.0;

func Enter():
	var player : Player = RoomManager.current_room.player;
	var vector_to_player = player.global_position - boss.global_position;
	var angle_increase = vector_to_player.angle();
	
	var angles = get_angles(amount_of_minis, range); 
	for angle in angles:
		var position_offset = Vector2((boss.diameter/2) + 10,0).rotated(deg_to_rad(angle) + angle_increase)
		var spawn_location = boss.global_position + position_offset;
		var mini_instance : BossSpawn = mini_fire_blades.instantiate();
		mini_instance.global_position = spawn_location;
		mini_instance.boss = boss;
		add_sibling(mini_instance);
	call_deferred("transition_to_still");

func transition_to_still():
	Transitioned.emit(self, "firebossstill")

func get_angles(amount : int, range : float):
	if amount == 1:
		return [0];
	var inc = range / (amount - 1);
	var running_angle = -range/2;
	var angles = [];
	
	for i in amount:
		angles.append(running_angle);
		running_angle += inc;
	
	return angles;
