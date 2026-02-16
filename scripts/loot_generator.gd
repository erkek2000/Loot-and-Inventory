extends Node


const ITEMS = preload("res://items/items.json")
var items_data := {}
var weapons := []
var armors := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# should give:
	#	items_data["weapons"]
	#	items_data["armors"]
	items_data = load_items_json("res://items/items.json")
	weapons = items_data["weapons"]
	armors = items_data["armors"]
	var loot = get_loot(weapons, 3)
	print(loot)


func generate_item(container_size: int, luck: float) -> Resource:
	return 


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
