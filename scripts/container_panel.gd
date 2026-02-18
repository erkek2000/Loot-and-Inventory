extends Panel


## Lists the items the loot container holds.
@export var Item_List: Array[Resource] = []

@onready var grid_container: GridContainer = $GridContainer
@onready var item_info_panel: Panel = %ItemInfoPanel
@onready var loot_generator: Node = %LootGenerator
const ARMOR_ICON = preload("uid://cloewy64jwg1k")
const WEAPON_ICON = preload("uid://bcsgdtm0apw32")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_loot()


func get_loot(item_count: int = 2):
	# Clear handmade placeholder buttons
	clear_children()
	Item_List.clear()
	for item in loot_generator.loot_data:
		Item_List.append(item)

	for item in Item_List:
		var item_btn := Button.new()
		if item is Weapon:
			item_btn.icon = WEAPON_ICON
		elif item is Armor:
			item_btn.icon = ARMOR_ICON
		
		# Add button style
		item_btn.custom_minimum_size = Vector2(64, 64)
		item_btn.expand_icon = true
		item_btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		item_btn.vertical_icon_alignment = VERTICAL_ALIGNMENT_CENTER

		# ---- RARITY STYLE ----
		var style := StyleBoxFlat.new()
		style.bg_color = get_rarity_color(item.rarity)
		# Rounded corners
		style.set_corner_radius_all(6)
		# Border
		style.set_border_width_all(2)
		style.border_color = Color.BLACK
		item_btn.add_theme_stylebox_override("normal", style)
		
		var hover_style := style.duplicate()
		hover_style.bg_color = style.bg_color.lightened(0.15)
		item_btn.add_theme_stylebox_override("hover", hover_style)
		
		# Add button functionality
		item_btn.mouse_entered.connect(_item_on_mouse_entered.bind(item))
		item_btn.mouse_exited.connect(Callable(self, "_item_on_mouse_exited"))
		item_btn.pressed.connect(Callable(self, "_item_pressed"))
		
		# Add to scene
		grid_container.add_child(item_btn)

func clear_children():
	# Clear handmade preview buttons in loot panel.
	for child in grid_container.get_children():
		child.queue_free()


func get_rarity_color(rarity: int) -> Color:
	match rarity:
		0: return Color(0.4, 0.4, 0.4)      # Common (gray)
		1: return Color(0.2, 0.8, 0.2)      # Uncommon (green)
		2: return Color(0.2, 0.4, 1.0)      # Rare (blue)
		3: return Color(0.6, 0.2, 1.0)      # Epic (purple)
		4: return Color(1.0, 0.5, 0.0)      # Legendary (orange)
		_: return Color.WHITE


#region SIGNALS
func _on_loot_button_pressed() -> void:
	loot_generator.generate_loot()
	get_loot()


func _item_on_mouse_entered(item: Resource) -> void:
	item_info_panel.visible = true
	item_info_panel.set_labels(item)


func _item_on_mouse_exited() -> void:
	item_info_panel.visible = false


func _item_pressed() -> void:
	pass

#endregion
