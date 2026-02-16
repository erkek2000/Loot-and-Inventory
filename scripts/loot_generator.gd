extends Node


var items_data := {}
var weapons := []
var armors := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	items_data = load_items_json("res://items/items.json")
	weapons = items_data["weapons"]
	armors = items_data["armors"]
	
	
	var loot_dict = get_loot(weapons, 3)
	print(loot_dict)
	var weapon_instance = dictionary_to_weapon(loot_dict)
	


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
