extends CanvasLayer
class_name UIController

@onready var fade_animation: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var level_label: Label = $"Control/Level Label"
@onready var main_menu: Control = $"Main Menu"
@onready var win_screen: Control = $"Win Screen"
@onready var pause_button: TextureButton = $Control/HBoxContainer/Pause
@onready var restart_button: TextureButton = $Control/HBoxContainer/Restart

func _ready() -> void:
	Global.ui_controller = self
	main_menu.show()
	restart_button.pressed.connect(func():
		if(Global.doing_something_important):
			return
		Global.restart_level()
		)
	pause_button.pressed.connect(func():
		if(Global.doing_something_important):
			return
		Global.go_to_main_menu()
		)
