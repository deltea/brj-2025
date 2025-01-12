extends Enemy
class_name Boss;

func _ready() -> void:
	super._ready();
	RoomManager.current_room.boss = self;
