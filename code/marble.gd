extends Entity
class_name Marble

@onready var sprite: AnimatedSprite2D = $Sprite

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
		var play_backwards: bool = false
		var rotation_direction: String = "side"
		match(direction):
			Vector2.UP:
				rotation_direction = "vertical"
			Vector2.DOWN:
				rotation_direction = "vertical"
				play_backwards = true
			Vector2.LEFT:
				play_backwards = true
		if(play_backwards):
			sprite.play_backwards(rotation_direction)
		else:
			sprite.play(rotation_direction)
	return success
	
func _movement_complete():
	super()
	rotation = 0
