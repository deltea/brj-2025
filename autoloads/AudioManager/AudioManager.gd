extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

# var sound = preload("res://assets/sfx/sound.wav")
# var music = preload("res://assets/music/music.wav")

## The current volume in percent the AudioStreamPlayer is at.[br]
## Call [method change_volume] to change volume.
var volume = 100

## Play a music track using the music AudioStreamPlayer.
func play_music(music: AudioStream):
	music_player.stream = music
	music_player.play()

## Play a sound by creating a separate AudioStreamPlayer.
func play_sound(sound: AudioStream, randomness: float = 0):
	var player = AudioStreamPlayer.new()
	player.pitch_scale = randf_range(1 - randomness, 1 + randomness)
	player.stream = sound
	player.bus = "SFX"
	player.connect("finished", player.queue_free)
	add_child(player)
	player.play()

## Set the volume of the AudioStreamPlayer by converting percent to decibels.
func change_volume(new_volume: int):
	volume = new_volume % (100 + new_volume)
	AudioServer.set_bus_volume_db(0, linear_to_db(volume / 100.0))
