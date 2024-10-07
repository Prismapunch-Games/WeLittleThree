extends Control

@onready var tutorial_sprite: TextureRect = $"MarginContainer/Control/Tutorial Sprite"
@onready var logo_control: Control = $MarginContainer/Control/Logo

func _ready() -> void:
	
	
	tutorial_sprite.modulate = Color(1,1,1,0)
	logo_control.modulate = Color(1,1,1,0)
	
	await get_tree().create_timer(2.0).timeout
	
	#fade in
	
	var tween: Tween = create_tween()
	tween.tween_property(logo_control, "modulate", Color(1,1,1,1), 1.0)
	await tween.finished
	
	#wait
	await get_tree().create_timer(2.0).timeout
	
	#fade out
	tween = create_tween()
	tween.tween_property(logo_control, "modulate", Color(1,1,1,0), 1.0)
	await tween.finished
	
	#wait
	await get_tree().create_timer(1.0).timeout
	
	#fade in tutorial
	tween = create_tween()
	tween.tween_property(tutorial_sprite, "modulate", Color(1,1,1,1), 1.0)
	await tween.finished
	await get_tree().create_timer(10.0).timeout
	tween = create_tween()
	tween.tween_property(tutorial_sprite, "modulate", Color(1,1,1,0), 1.0)
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,0), 1.0)
	await tween.finished
	hide()
