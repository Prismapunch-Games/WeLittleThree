extends Sprite2D

func _process(delta: float) -> void:
	var tile: Vector2i = Global.tilemap.local_to_map(get_viewport().get_mouse_position() + Vector2(32,0))
	position = Global.tilemap.map_to_local(tile) - Vector2(32, 0)
	return
