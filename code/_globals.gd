extends Node

var tilemap: TilemapObject
var selected_entity: Entity
var leaver: Leaver
var current_level: Node2D
var ui_controller: UIController
var top_level_node: Node2D
var current_level_index: int = 0
var loading_next_level: bool = false

var levels: Array[PackedScene] = [
	preload("res://scenes/levels/level_1_1.tscn"),
	preload("res://scenes/levels/level_1_2.tscn"),
	preload("res://scenes/levels/level_1_3.tscn")
]

func _ready():
	top_level_node = get_node("/root/Main")
	
func load_level(index: int):
	var level: PackedScene = levels[index]
	var loaded_level = level.instantiate()
	top_level_node.add_child(loaded_level)
	current_level = loaded_level
	ui_controller.level_label.text = current_level.name
	
func load_next_level():
	if(loading_next_level):
		return
	loading_next_level = true
	selected_entity = null
	tilemap = null
	leaver = null
	current_level.queue_free()
	current_level = null
	current_level_index += 1
	if(current_level_index < levels.size()):
		load_level(current_level_index)
	else: #you win
		print("you win")
		end_game()
		loading_next_level = false
		return
	ui_controller.fade_animation.play("fade_in")
	loading_next_level = false
	

func check_for_completion():
	for steppable in tilemap.steppables:
		if(steppable is not ButtonButton):
			continue
		if(!steppable.pressed):
			return

	for entity in tilemap.nodes:
		print("found %s" % entity.name)
		if(!(entity is ControllableEntity)):
			continue
		print("destroying %s" % entity.name)
		entity.call_deferred("destroy")
	await get_tree().create_timer(2.0).timeout
	check_for_level_end()
		
func check_for_level_end():
	print("level complete")
	ui_controller.fade_animation.play_backwards("fade_in")
	await ui_controller.fade_animation.animation_finished
	load_next_level()
	
func start_game():
	ui_controller.fade_animation.play_backwards("fade_in")
	await ui_controller.fade_animation.animation_finished
	current_level_index = 0
	load_level(current_level_index)
	ui_controller.main_menu.hide()
	ui_controller.fade_animation.play("fade_in")
	
func end_game():
	ui_controller.win_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	ui_controller.win_screen.show()
	ui_controller.fade_animation.play("fade_in")
	
func restart_game():
	ui_controller.win_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	ui_controller.fade_animation.play_backwards("fade_in")
	await ui_controller.fade_animation.animation_finished
	ui_controller.win_screen.hide()
	ui_controller.main_menu.mouse_filter = Control.MOUSE_FILTER_STOP
	ui_controller.main_menu.show()
	ui_controller.fade_animation.play("fade_in")
	
