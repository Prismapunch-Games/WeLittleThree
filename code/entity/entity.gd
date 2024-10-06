extends Node2D
class_name Entity

enum EntityFlags {
	FLAG_NONE,
	FLAG_RED,
	FLAG_BLUE,
	FLAG_YELLOW
}


var moving: bool = false
var moving_to_position: Vector2

var entity_flags: EntityFlags = EntityFlags.FLAG_NONE



func _setup():
	return

func _ready() -> void:
	_setup()
	Global.tilemap.add_node(self)

func _can_move_in_direction(direction: Vector2):
	var next_tile = position + direction * 64
	var cell_data = Global.tilemap.get_cell_tile_data(Global.tilemap.local_to_map(next_tile))
	if(!cell_data.get_custom_data("floor")):
		return false
	var hitting_object: Node2D = Global.tilemap.get_object_in_cell(next_tile)
	if(hitting_object):
		if(hitting_object is Entity):
			var moved: bool = hitting_object.bump(self, direction)
			return moved
		return false
	return true

func _move(direction: Vector2):
	if(!_can_move_in_direction(direction)):
		return false
	moving_to_position = position + direction * 64
	moving = true
	var tween = create_tween()
	tween.tween_property(self, "position", moving_to_position, 0.35)
	tween.tween_callback(Callable(self, "_movement_complete"))
	return true

func _movement_complete():
	moving = false
	moving_to_position = Vector2.ZERO
	
func bump(bumper: Entity, direction: Vector2):
	return false
