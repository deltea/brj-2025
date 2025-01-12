extends State;
class_name MiniCharge;

@export var mini_blade : BossSpawn;
@export var initial_speed = 300;
@export var goal_speed = 300.0;

var boss : Enemy;
var player : Player;

func Enter():
	if not mini_blade.split_up:
		player = RoomManager.current_room.player;
		boss = mini_blade.boss;
		
		#var vector_to_player = player.global_position - mini_blade.global_position;
		#vector_to_player = vector_to_player.normalized();
		
		var vector_away_boss = mini_blade.global_position - boss.global_position; 
		vector_away_boss = vector_away_boss.normalized();
		
		mini_blade.apply_central_impulse(vector_away_boss * initial_speed);
		#mini_blade.apply_central_impulse(vector_to_player * goal_speed);
