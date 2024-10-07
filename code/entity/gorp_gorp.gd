extends Entity
class_name GorpGorp


func bump(bumper: Entity, _direction: Vector2):
	if(bumper.entity_flags == EntityFlags.FLAG_BLUE):
		destroy()
		return true
	return false
