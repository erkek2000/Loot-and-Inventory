extends Panel


## Lists the items the loot container holds.
@export var Item_List: Array[Resource] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_children()
	#generate_loot()
	#show_loot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func clear_children():
	var grid_container = $GridContainer
	# Clear handmade preview buttons in loot panel.
	for child in grid_container.get_children():
		child.queue_free()


func generate_loot():
	pass


func show_loot():
	pass
