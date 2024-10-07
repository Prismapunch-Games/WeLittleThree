extends Steppable
class_name ButtonButton

@export var button_color: Entity.EntityFlags = Entity.EntityFlags.FLAG_NONE
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var click_sound: AudioStreamPlayer2D = $"Click Sound"

var pressed: bool = false

func stepped_on(entity: Entity):
	if(pressed):
		return
	if(button_color == entity.entity_flags):
		pressed = true
		sprite.play("down")
		click_sound.play()
	Global.check_for_completion()
