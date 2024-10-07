extends Node2D
class_name Steppable

func _ready() -> void:
	Global.tilemap.add_node(self)

func stepped_on(_entity: Entity):
	return false
