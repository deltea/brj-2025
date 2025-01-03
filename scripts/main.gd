extends Node2D

signal released;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Better way of doing this, just for now
	if Input.is_action_pressed("click"):
		%Player.dragging = true;
	elif %Player.dragging == true:
		released.emit()
		%Player.dragging = false;
