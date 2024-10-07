extends Control

@onready var start_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Start"
@onready var credits_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Credits"
@onready var exit_button: Button = $"MarginContainer/Control/VBoxContainer2/Button Holder/Exit"
@onready var version_label: Label = $"MarginContainer/Control/Version Label"
@onready var credits_window: ColorRect = $MarginContainer/Control/Credits
@onready var close_credits: TextureButton = $"MarginContainer/Control/Credits/Close Credits"

func _ready() -> void:
	start_button.pressed.connect(func():
		Global.music_holder.play_click()
		if(Global.doing_something_important):
			return
		Global.start_game()
		mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
		)
	exit_button.pressed.connect(func():
		Global.music_holder.play_click()
		get_tree().quit()
		)
	credits_button.pressed.connect(func():
		Global.music_holder.play_click()
		credits_window.show()
		)
	close_credits.pressed.connect(func():
		Global.music_holder.play_click()
		credits_window.hide()
		)
	version_label.text = "v%s" % ProjectSettings.get_setting("application/config/version")
