extends Control

@onready var return_button: Button = $"MarginContainer/Control/Return Button"

func _ready():
	return_button.pressed.connect(func():
		if(Global.doing_something_important):
			return
		Global.restart_game()
		)
