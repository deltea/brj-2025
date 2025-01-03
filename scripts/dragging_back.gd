extends Line2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clear_points();
	if get_parent().dragging:
		add_point(Vector2.ZERO)
		add_point(to_local(get_global_mouse_position()))
