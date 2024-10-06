extends TileMapLayer
class_name TilemapObject

var nodes: Array[Node2D]
var steppables: Array[Steppable]

func _ready() -> void:
	Global.tilemap = self

func add_node(node: Node2D):
	if(node is Steppable):
		steppables.append(node)
	else:
		nodes.append(node)
	
func remove_node(node: Node2D):
	
	if(node is Steppable):
		steppables.erase(node)
	else:
		nodes.erase(node)
	
	
func get_object_in_cell(world_position: Vector2i):
	var cell_position: Vector2i = local_to_map(world_position)
	for node in nodes:
		if(local_to_map(node.position) == cell_position):
			return node
		if(node is Entity):
			if(local_to_map(node.moving_to_position) == cell_position):
				return node
	return null
	
func get_steppable_in_cell(world_position: Vector2i):
	var cell_position: Vector2i = local_to_map(world_position)
	for steppable in steppables:
		if(local_to_map(steppable.position) == cell_position):
			return steppable
	return null
		
