extends Entity
class_name ControllableEntity

var hovered: bool = false

@onready var selected_sprite: Sprite2D = $Selected
@onready var click_catcher: Area2D = $"Click Catcher"
@onready var sprite: AnimatedSprite2D = $"Main Sprite"
@onready var shadow: Sprite2D = $Shadow

var last_direction: Vector2

var destroying: bool = false

func _ready() -> void:
	super()
	selected_sprite.hide()
	click_catcher.mouse_entered.connect(Callable(self, "_mouse_entered"))
	click_catcher.mouse_exited.connect(Callable(self, "_mouse_exited"))

func _mouse_entered() -> void:
	hovered = true
	
func _mouse_exited() -> void:
	hovered = false
	
func _input(event: InputEvent) -> void:
	if(!hovered):
		return
	if(destroying):
		return
	if(event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT):
		select()
		
func select():
	if(Global.selected_entity):
		Global.selected_entity.deselect()
	Global.selected_entity = self
	selected_sprite.show()
	
func deselect():
	selected_sprite.hide()
	
func _process(delta: float) -> void:
	if(Global.selected_entity != self):
		return
	if(destroying):
		return
	if(Input.is_key_pressed(KEY_G)):
		destroy()
	_process_movement()
	
func _process_movement(override_moving: bool = false):
	var direction: Vector2 = Vector2(Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"), Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up"))
	if(direction.x && direction.y):
		direction = Vector2(direction.x, 0)
	if(direction.length() && (override_moving || !moving)):
		_move(direction)
		return true
	return false

func _move(direction: Vector2):
	var next_tile = position + direction * Global.tilemap.tile_set.tile_size.x
	var pushing_object: Node2D = Global.tilemap.get_object_in_cell(next_tile)
	#SHITCODE: We assume that if we're "allowed" in a tile with another Entity that's solid 
	# we're pushing it
	if(!(pushing_object is Entity)): 
		pushing_object = null
		
	if(!super(direction)):
		return
	last_direction = direction
	sprite.offset = Vector2.ZERO
	match(direction):
		Vector2.UP:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			if(pushing_object):
				sprite.animation = "up_push"
				sprite.offset.y = -256-64-16
			else:
				sprite.animation = "up_move"
				sprite.offset.y = 0
		Vector2.DOWN:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			if(pushing_object):
				sprite.animation = "down_push"
				sprite.offset.y = 256+64+16
			else:
				sprite.animation = "down_move"
				sprite.offset.y = 0
		Vector2.LEFT:
			sprite.scale.x = sprite.scale.x * -sign(sprite.scale.x)
			if(pushing_object):
				sprite.animation = "side_push"
				sprite.offset.x = 256+64+16
			else:
				sprite.animation = "side_move"
				sprite.offset.x = 0
		Vector2.RIGHT:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			if(pushing_object):
				sprite.animation = "side_push"
				sprite.offset.x = 256+64+16
			else:
				sprite.animation = "side_move"
				sprite.offset.x = 0
			
func _movement_complete():
	super()
	if(destroying):
		return
	if(_process_movement(true)):
		return
	match(last_direction):
		Vector2.UP:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			sprite.animation = "up_idle"
			sprite.offset = Vector2.ZERO
		Vector2.DOWN:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			sprite.animation = "down_idle"
			sprite.offset = Vector2.ZERO
		Vector2.LEFT:
			sprite.scale.x = sprite.scale.x * -sign(sprite.scale.x)
			sprite.animation = "side_idle"
			sprite.offset = Vector2.ZERO
		Vector2.RIGHT:
			sprite.scale.x = sprite.scale.x * sign(sprite.scale.x)
			sprite.animation = "side_idle"
			sprite.offset = Vector2.ZERO

func destroy():
	if(destroying):
		return
	destroying = true
	Global.tilemap.remove_node(self)
	if(Global.selected_entity == self):
		Global.selected_entity = null
	deselect()
	sprite.animation = "spin"
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", Vector2(position.x, -128), 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	var shadow_position = shadow.global_position
	remove_child(shadow)
	add_sibling(shadow)
	shadow.global_position = shadow_position
	tween.tween_callback(func():
		shadow.queue_free()
		queue_free()
		)
