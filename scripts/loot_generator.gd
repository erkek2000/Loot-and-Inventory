extends Node


var items_data := {}
var loot_data : Array[Resource]= []
var weapons : Array[Weapon]= []
var armors : Array[Armor]= []

const ARMOR_ICON = preload("uid://cloewy64jwg1k")
const SWORD_ICON = preload("uid://bcsgdtm0apw32")

@onready var container_panel: Panel = %ContainerPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items_data = load_items_json("res://items/items.json")
	# Convert JSON to real resources immediately
	for weapon_dict in items_data["weapons"]:
		weapons.append(dictionary_to_weapon(weapon_dict))
	for armor_dict in items_data["armors"]:
		armors.append(dictionary_to_armor(armor_dict))

	generate_loot()

	#var loot_dict = get_loot(weapons, 3)
	#print(loot_dict)
	#var weapon_instance = dictionary_to_weapon(loot_dict)


func generate_loot() -> Array[Resource]:
	loot_data.clear()
	
	var item_count := randi_range(2, 15)
	
	for i in item_count:
		var item := generate_random_item()
		loot_data.append(item)
	
	return loot_data


func generate_random_item() -> Resource:
	if randf() < 0.5:
		return generate_weapon()
	else:
		return generate_armor()


func roll_rarity() -> int:
	var roll := randf()

	if roll < 0.50:
		return 1
	elif roll < 0.75:
		return 2
	elif roll < 0.90:
		return 3
	elif roll < 0.98:
		return 4
	else:
		return 5


func generate_weapon() -> Weapon:
	var base_weapon : Weapon = weapons.pick_random()
	var weapon : Weapon = base_weapon.duplicate()
	
	weapon.rarity = roll_rarity()
	apply_rarity_scaling(weapon)
	
	return weapon

func generate_armor() -> Armor:
	var base_armor : Armor = armors.pick_random()
	var armor : Armor = base_armor.duplicate()
	
	armor.rarity = roll_rarity()
	apply_rarity_scaling(armor)
	
	return armor


func apply_rarity_scaling(item: Resource) -> void:
	var multiplier := 1.0
	
	match item.rarity:
		1: multiplier = 1.0
		2: multiplier = 1.15
		3: multiplier = 1.30
		4: multiplier = 1.50
		5: multiplier = 1.80
	
	if item is Weapon:
		item.damage_min *= multiplier
		item.damage_max *= multiplier
	
	elif item is Armor:
		item.defence *= multiplier


func get_random_weapon() -> Weapon:
	return weapons.pick_random()


func get_random_armor() -> Armor:
	return armors.pick_random()


func load_items_json(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Invalid path for items.json: %s" % path)
		return {}
	
	var json_text := file.get_as_text()
	file.close()
	
	var json := JSON.new()
	var parse_result := json.parse(json_text)
	
	if parse_result != OK:
		push_error("items.json Parse Error from path: %s" % path)
		return {}
	
	return json.data


func get_loot(items: Array, max_tier: int, luck: int = 0) -> Dictionary:
	var filtered := []
	
	for item in items:
		if item["rarity_tier"] <= max_tier:
			filtered.append(item)
	
	return get_weighted_random_item(filtered)


func get_weighted_random_item(items: Array) -> Dictionary:
	var total_weight := 0
	
	for item in items:
		total_weight += item["spawn_weight"]
	
	var roll := randf() * total_weight
	
	for item in items:
		roll -= item["spawn_weight"]
		if roll <= 0:
			return item
	
	return items.back()


func dictionary_to_weapon(data: Dictionary) -> Weapon:
	var w := Weapon.new()
	w.name = data["name"]
	w.damage_min = data["damage_min"]
	w.damage_max = data["damage_max"]
	w.speed = data["speed"]
	w.crit_chance = data["crit_chance"]
	w.crit_damage = data["crit_damage"]
	w.knockback = data["knockback"]
	w.lore = data["lore"]
	w.rarity = data["rarity_tier"]
	w.is_material = data["is_material"]
	return w

func dictionary_to_armor(data: Dictionary) -> Armor:
	var a := Armor.new()
	a.name = data["name"]
	a.defence = data["defence"]
	a.move_speed = data["move_speed"]
	a.knockback_resistance = data["knockback_resistance"]
	a.aggro = data["aggro"]
	a.is_uniform = data["is_uniform"]
	a.uniform_faction = data["uniform_faction"]
	a.lore = data["lore"]
	a.rarity = data["rarity_tier"]
	a.is_material = data["is_material"]
	return a
