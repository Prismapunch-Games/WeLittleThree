extends Entity
class_name Marble

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	Global.tilemap.add_node(self)

func bump(bumper: Entity, direction: Vector2):
	print(bumper.entity_flags)
	if(bumper.entity_flags != EntityFlags.FLAG_RED):
		return false
	return _move(direction)

func _move(direction: Vector2):
	var success: bool = super(direction)
	if(success):
		var tween = create_tween()
		var rotation_direction = 360
		if(sign(direction.x) == -1):
			rotation_direction = -360
		tween.tween_property(self, "rotation", deg_to_rad(rotation_direction), 0.30)
	return success
	
func _movement_complete():
	super()
	rotation = 0
