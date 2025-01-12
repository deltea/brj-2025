extends State
class_name FireBossStill;

@export var boss : Entity;

@export var attack_interval = 2;

@onready var countdown = attack_interval;
var attacks : Array;

func Enter():
	countdown = attack_interval;	
	var parent = get_parent();
	var states = parent.states;
	attacks = states.keys();
	attacks.erase("firebossstill")

func Update(delta : float):
	countdown -= delta;
	if countdown < 0:
		var random_attack = attacks.pick_random();
		Transitioned.emit(self, random_attack);
