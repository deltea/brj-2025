extends Area2D
class_name ModifierPit;

var modifier : Modifier;

func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.add_modifier(modifier);
