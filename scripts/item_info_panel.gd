extends Panel


@onready var v_box_container: VBoxContainer = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	clear_labels()
	#var item_label = new Label
	#item_label.text = 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	#self.global_position = 


func set_labels(item: Resource) -> void:
	clear_labels()
	
	# Item Name (always first)
	var name_label := Label.new()
	name_label.text = item.name
	name_label.add_theme_font_size_override("font_size", 18)
	v_box_container.add_child(name_label)
	
	# Weapon stats
	if item is Weapon:
		add_label("Damage: %s - %s" % [item.damage_min, item.damage_max])
		add_label("Speed: %s" % item.speed)
		add_label("Crit Chance: %s%%" % int(item.crit_chance * 100))
		add_label("Crit Damage: x%s" % item.crit_damage)
		add_label("Knockback: %s" % item.knockback)
	
	# Armor stats
	elif item is Armor:
		add_label("Defence: %s" % item.defence)
		add_label("Move Speed: %s" % item.move_speed)
		add_label("Knockback Resistance: %s" % item.knockback_resistance)
		add_label("Aggro: %s" % item.aggro)
	
	# Lore (shared)
	if item.lore != "":
		add_label("")
		add_label(item.lore)


func add_label(text: String) -> void:
	var label := Label.new()
	label.text = text
	v_box_container.add_child(label)


func clear_labels():
	# Clear handmade preview buttons in loot panel.
	for child in v_box_container.get_children():
		child.queue_free()
