class_name Room extends Node2D

var player : Player
var camera : Camera
var boss : Enemy;

func _enter_tree() -> void:
	RoomManager.current_room = self
