extends Node2D
class_name MusicHolder

@onready var click_sound: AudioStreamPlayer2D = $"Click Sound"
@onready var win_sound: AudioStreamPlayer2D = $"Win Sound"

func _ready():
	Global.music_holder = self

func play_click():
	click_sound.play()
