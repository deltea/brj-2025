extends Area2D
class_name ModifierPit;

@export var fades = false;
@export var fade_time = 4.0;

var modifier : Modifier;

func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		body.add_modifier(modifier);

func _process(delta: float) -> void:
	if fades:
		fade_time-=delta;
		if fade_time < 1:
			if fade_time < 0:
				queue_free()
			modulate.a = fade_time
