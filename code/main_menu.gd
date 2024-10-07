extends Control

@onready var start_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Start"
@onready var credits_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Credits"
@onready var exit_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Exit"
@onready var version_label: Label = $"MarginContainer/Control/Version Label"

func _ready() -> void:
	start_button.pressed.connect(func():
		if(Global.doing_something_important):
			return
		Global.start_game()
		mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
		)
	exit_button.pressed.connect(func():
		get_tree().quit()
		)
	version_label.text = "v%s" % ProjectSettings.get_setting("application/config/version")
