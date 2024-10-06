extends TileMapLayer
class_name TilemapObject

var nodes: Array[Node2D]

func _ready() -> void:
	Global.tilemap = self

func add_node(node: Node2D):
	nodes.append(node)
	
func remove_node(node: Node2D):
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
		
