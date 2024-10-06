extends ControllableEntity

func _setup():
	super()
	print("setting entity flags to red")
	entity_flags = EntityFlags.FLAG_RED
