extends CanvasLayer
class_name UIController

@onready var fade_animation: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var level_label: Label = $"Control/Level Label"
@onready var main_menu: Control = $"Main Menu"
@onready var win_screen: Control = $"Win Screen"

func _ready() -> void:
	Global.ui_controller = self
	main_menu.show()
