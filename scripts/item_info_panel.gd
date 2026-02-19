extends Panel


@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var looting_scene_main: Control = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Very important to make this panel and ALL its children mouse ignoring.
	# Otherwise cursor enters the panel which would mean it will emit button
	# exited signal.
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	self.visible = false
	clear_labels()
	

func _process(delta: float) -> void:
	var offset := Vector2(0, 0)
	if visible:
		global_position = get_viewport().get_mouse_position() + offset

func set_labels(item: Resource) -> void:
	clear_labels()
	
	var name_label := Label.new()
	name_label.text = item.name
	name_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# Label Style
	name_label.add_theme_font_size_override("font_size", 18)
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	# Set rarity color
	var rarity_color : Color = looting_scene_main.get_rarity_color(item.rarity)
	name_label.add_theme_color_override("font_color", rarity_color)

	v_box_container.add_child(name_label)

	add_label("") # spacing
	
	# Weapon stats
	if item is Weapon:
		add_label(tr("STAT_DAMAGE") % [item.damage_min, item.damage_max])
		add_label(tr("STAT_SPEED") % item.speed)
		add_label(tr("STAT_CRIT_CHANCE") % int(item.crit_chance * 100))
		add_label(tr("STAT_CRIT_DAMAGE") % item.crit_damage)
		add_label(tr("STAT_KNOCKBACK") % item.knockback)
	
	# Armor stats
	elif item is Armor:
		add_label(tr("STAT_DEFENCE") % item.defence)
		add_label(tr("STAT_MOVE_SPEED") % item.move_speed)
		add_label(tr("STAT_KB_RESIST") % item.knockback_resistance)
		add_label(tr("STAT_AGGRO") % item.aggro)
	
	# Lore (shared)
	if item.lore != "":
		add_label("")
		add_label(tr(item.lore))  # assuming lore is already a key
	
	await get_tree().process_frame
	size.y = v_box_container.get_combined_minimum_size().y


func add_label(text: String) -> void:
	var label := Label.new()
	label.text = text
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	v_box_container.add_child(label)



func clear_labels():
	# Clear handmade preview buttons in loot panel.
	for child in v_box_container.get_children():
		child.queue_free()
