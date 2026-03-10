extends Button
class_name ItemButton

signal right_clicked(item)
signal hover_looted(item)

@export var item : Resource

# key used for hover-looting
const LOOT_KEY := "loot_hover" 


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	gui_input.connect(_on_gui_input)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			right_clicked.emit(item)


func _on_mouse_entered() -> void:
	if Input.is_action_pressed(LOOT_KEY):
		hover_looted.emit(item)
