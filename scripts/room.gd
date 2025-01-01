class_name Room extends Node2D

func _enter_tree() -> void:
	RoomManager.current_room = self
