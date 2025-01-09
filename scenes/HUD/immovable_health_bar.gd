extends "res://scripts/health_bar_base.gd"


func _ready() -> void:
	entity = RoomManager.current_room.player;
