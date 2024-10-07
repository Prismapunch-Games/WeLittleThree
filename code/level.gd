extends Node2D
class_name Level

@onready var help_grid: Sprite2D = $"Helper Grid"

func _ready() -> void:
	help_grid.hide()
