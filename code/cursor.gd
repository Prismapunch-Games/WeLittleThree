extends Sprite2D

func _process(delta: float) -> void:
	var tile: Vector2i = Global.tilemap.local_to_map(get_viewport().get_mouse_position() + Vector2(128,-32))
	position = Global.tilemap.map_to_local(tile) - Vector2(128, -32)
	return
