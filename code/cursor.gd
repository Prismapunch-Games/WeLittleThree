extends Sprite2D

func _process(_delta: float) -> void:
	if(!Global.tilemap):
		return
	var tile: Vector2i = Global.tilemap.local_to_map(get_viewport().get_mouse_position() + Vector2(128,-32))
	position = Global.tilemap.map_to_local(tile) - Vector2(128, -32)
	return
