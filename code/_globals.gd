extends Node

var tilemap: TilemapObject
var selected_entity: Entity
var leaver: Leaver

func check_for_completion():
	var complete: bool = true
	for steppable in tilemap.steppables:
		if(steppable is not ButtonButton):
			continue
		if(!steppable.pressed):
			complete = false
			break
	if(complete):
		leaver.enable()
