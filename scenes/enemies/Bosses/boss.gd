extends Enemy

func _ready() -> void:
	super._ready();
	RoomManager.current_room.boss = self;
