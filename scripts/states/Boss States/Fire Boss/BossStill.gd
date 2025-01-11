extends State
class_name FireBossStill;

@export var attacks = [];
@export var boss : Entity;

@export var attack_interval = 4;

@onready var countdown = attack_interval;

func Process(delta : float):
	countdown -= delta;
	if countdown < 0:
		Transitioned.emit(self, attacks.pick_random());
