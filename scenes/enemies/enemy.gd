extends Entity
class_name Enemy;

@onready var player : Player = %Player;

func _ready():
	super._ready();

func _physics_process(delta: float) -> void:
	super._physics_process(delta);

func _on_died() -> void:
	queue_free();
