extends Entity
class_name ControllableEntity

var hovered: bool = false

@onready var selected_sprite: Sprite2D = $Selected
@onready var click_catcher: Area2D = $"Click Catcher"

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
	var direction: Vector2 = Vector2(Input.get_action_raw_strength("right") - Input.get_action_raw_strength("left"), Input.get_action_raw_strength("down") - Input.get_action_raw_strength("up"))
	if(direction.length() && !moving):
		_move(direction)
