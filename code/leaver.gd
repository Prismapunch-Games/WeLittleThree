extends Steppable
class_name Leaver

@onready var sprite: AnimatedSprite2D = $Sprite2D
@export var starts_on: bool = true
var open: bool = false

func _ready() -> void:
	super()
	Global.leaver = self
	if(starts_on):
		enable()

func enable():
	sprite.animation = "on"
	open = true
	
func stepped_on(entity: Entity):
	if(!open):
		return
	if(entity is not ControllableEntity):
		return
	entity.destroy()
