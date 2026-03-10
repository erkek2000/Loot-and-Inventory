extends Panel

@onready var grid_container: GridContainer = $GridContainer
@onready var item_info_panel: Panel = %ItemInfoPanel
var inventory_size: int = 28
var intentory_max_size: int = 56

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_children()
	create_inventory_buttons()


func clear_children():
	# Clear handmade preview buttons in loot panel.
	for child in grid_container.get_children():
		child.queue_free()


func create_inventory_buttons():
	for button in intentory_max_size:
		var btn := Button.new()
		
		# Add button style
		btn.custom_minimum_size = Vector2(64, 64)
		btn.expand_icon = true
		btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		btn.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER

		# Best done as a custom button that merges rarity color background with icon tbh..
		# ---- RARITY STYLE ----
		#var style := StyleBoxFlat.new()
		#style.bg_color = looting_scene_main.get_rarity_color(item.rarity)
		## Rounded corners
		#style.set_corner_radius_all(6)
		## Border
		#style.set_border_width_all(2)
		#style.border_color = Color.BLACK
		#btn.add_theme_stylebox_override("normal", style)
		#
		#var hover_style := style.duplicate()
		#hover_style.bg_color = style.bg_color.lightened(0.15)
		#btn.add_theme_stylebox_override("hover", hover_style)
		#
		## Add button functionality
		#btn.mouse_entered.connect(_item_on_mouse_entered.bind(item))
		btn.mouse_exited.connect(Callable(self, "_item_on_mouse_exited"))
		btn.pressed.connect(Callable(self, "_item_pressed"))
		
		# Add to scene
		if button >= inventory_size:
			btn.disabled = true
		grid_container.add_child(btn)


#region SIGNALS
func _item_on_mouse_entered(item: Resource) -> void:
	item_info_panel.visible = true
	item_info_panel.set_labels(item)


func _item_on_mouse_exited() -> void:
	item_info_panel.visible = false


func _item_pressed() -> void:
	pass

#endregion
