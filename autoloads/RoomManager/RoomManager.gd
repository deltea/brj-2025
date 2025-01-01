extends CanvasLayer

# var room: PackedScene = preload("res://rooms/room.tscn")

## The current loaded room object.
var current_room: Room

## Change the current room to another room from the name of the room.
func change_room(room_name: String):
	var scene = get(room_name + "_room")
	if not scene:
		printerr(room_name + " is not a valid room")
		return

	get_tree().change_scene_to_packed(scene)
