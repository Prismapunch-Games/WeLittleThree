extends Control

@onready var return_button: Button = $"MarginContainer/Control/Return Button"

func _ready():
	return_button.pressed.connect(func():
		Global.restart_game()
		)
