extends Control

@onready var tutorial_sprite: TextureRect = $"MarginContainer/Control/Tutorial Sprite"

func _ready() -> void:
	var tween: Tween = create_tween()
	tutorial_sprite.modulate = Color(1,1,1,0)
	tween.tween_property(tutorial_sprite, "modulate", Color(1,1,1,1), 1.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	tween = create_tween()
	tween.tween_property(tutorial_sprite, "modulate", Color(1,1,1,0), 1.0)
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1.0)
	await tween.finished
	hide()
