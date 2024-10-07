extends CanvasLayer
class_name UIController

@onready var fade_animation: AnimationPlayer = $ColorRect/AnimationPlayer
@onready var level_label: Label = $"Control/Level Label"

func _ready() -> void:
	Global.ui_controller = self
