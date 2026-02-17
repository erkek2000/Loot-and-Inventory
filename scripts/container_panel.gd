extends Panel


## Lists the items the loot container holds.
@export var Item_List: Array[Resource] = []

@onready var grid_container: GridContainer = $GridContainer
@onready var item_info_panel: Panel = %ItemInfoPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_loot()


func generate_loot(item_count: int = 2):
	# Clear handmade placeholder buttons
	clear_children()
	
	for item in Item_List:
		var item_btn := Button.new()
		#item_btn.text = "Item1"
		#item_btn.icon = preload("uid://cl8plgebl8pqc")
		# Add button style
		#item_btn.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		#item_btn.vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
		#item_btn.expand_icon = true
		#item_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		#item_btn.tooltip_text = "Item1"
		# Add button functionality
		item_btn.mouse_entered.connect(Callable(self, "_item_on_mouse_entered"))
		item_btn.mouse_exited.connect(Callable(self, "_item_on_mouse_exited"))
		item_btn.pressed.connect(Callable(self, "_item_pressed"))
		# Add to scene
		grid_container.add_child(item_btn)

func clear_children():
	var grid_container = $GridContainer
	# Clear handmade preview buttons in loot panel.
	for child in grid_container.get_children():
		child.queue_free()

#region SIGNALS
func _on_loot_button_pressed() -> void:
	generate_loot()


func _item_on_mouse_entered() -> void:
	item_info_panel.visible = true


func _item_on_mouse_exited() -> void:
	item_info_panel.visible = false


func _item_pressed() -> void:
	pass

#endregion
