extends Entity
class_name GorpGorp


func bump(bumper: Entity, _direction: Vector2):
	if(bumper.entity_flags == EntityFlags.FLAG_BLUE):
		var sfx = Global.one_shot_smack.instantiate()
		add_sibling(sfx)
		sfx = Global.one_shot_ouch.instantiate()
		add_sibling(sfx)
		destroy()
		return true
	return false
