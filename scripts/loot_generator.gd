extends Node

var items_data := {}
var loot_data : Array[Resource] = []
var weapons : Array[Weapon] = []
var armors : Array[Armor] = []

const ARMOR_ICON = preload("uid://cloewy64jwg1k")
const SWORD_ICON = preload("uid://bcsgdtm0apw32")

@onready var container_panel: Panel = %ContainerPanel


func _ready() -> void:
	items_data = load_items_json("res://items/items.json")
	
	# Convert JSON to real resources
	for weapon_dict in items_data["weapons"]:
		weapons.append(dictionary_to_weapon(weapon_dict))
	
	for armor_dict in items_data["armors"]:
		armors.append(dictionary_to_armor(armor_dict))

	generate_loot()


# =========================
# LOOT GENERATION
# =========================

func generate_loot() -> Array[Resource]:
	loot_data.clear()
	
	var item_count := randi_range(2, 20)
	
	for i in item_count:
		var item := generate_random_item()
		loot_data.append(item)
	
	return loot_data


func generate_random_item() -> Resource:
	if randf() < 0.5:
		return get_weighted_random(weapons)
	else:
		return get_weighted_random(armors)


# =========================
# WEIGHTED SELECTION
# =========================

func get_weighted_random(array: Array) -> Resource:
	var total_weight := 0.0
	
	for element in array:
		total_weight += element.spawn_weight
	
	var roll := randf() * total_weight
	var current := 0.0
	
	for element in array:
		current += element.spawn_weight
		if roll <= current:
			return element.duplicate()
	
	return array[0].duplicate()


# =========================
# JSON LOADING
# =========================

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


# =========================
# DICTIONARY → RESOURCE
# =========================

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
	w.spawn_weight = data["spawn_weight"]  # 🔥 IMPORTANT
	
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
	a.spawn_weight = data["spawn_weight"]  # 🔥 IMPORTANT
	
	a.is_material = data["is_material"]
	return a
