extends AudioStreamPlayer2D
class_name OneShotAudio2D

func _ready():
	await finished
	queue_free()
