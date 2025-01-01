extends Node

var time = 0.0

func _process(delta: float) -> void:
	time += delta

## Create a timer and asynchronously wait for timeout.
## Use like `await Clock.wait(1.0)`.
func wait(duration: float):
	await get_tree().create_timer(duration, false, false, true).timeout

## Stops time for a very short time (like .1 second) to add juice. Be careful of this when tampering with time_scale somewhere else
func hitstop(duration: float):
	Engine.time_scale = 0.0
	await wait(duration)
	Engine.time_scale = 1.0
