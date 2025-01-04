extends Label
class_name DamageIndicator

@export var speed = 200;
var damage_amount : int = -1;
var velocity_mult : float;
var deceleration_factor : float;

var velocity : Vector2;
var duration : float;
var alpha_decrement : float;

func set_up(global_positionL : Vector2, damage_amountL : int, durationL : float = 0.5, deceleration_factorL : float = 0.1, velocity_multL : float = 1):
	global_position = global_positionL;
	
	damage_amount = damage_amountL;
	velocity_mult = velocity_multL;
	deceleration_factor = deceleration_factorL;
	
	duration = durationL;
	alpha_decrement = 1/duration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("In scene")
	text = str(damage_amount);
	velocity = randomize_velocity(velocity_mult);
	var tween = get_tree().create_tween();
	tween.set_parallel();
	tween.tween_property(self, "velocity", Vector2(velocity * 0.1), duration);
	tween.tween_property(self, "modulate:a", 0, duration)
	tween.chain().tween_callback(queue_free);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += velocity * delta;

func randomize_velocity(velocity_mult : float) -> Vector2:
	var direction = Vector2.LEFT.rotated(randf_range(0, 2 * PI));
	return direction * speed * velocity_mult;
