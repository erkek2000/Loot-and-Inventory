extends Panel


@onready var v_box_container: VBoxContainer = $VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	clear_children()
	#var item_label = new Label
	#item_label.text = 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	#self.global_position = 


#func add_label

func clear_children():
	var v_box_container = $GridContainer
	# Clear handmade preview buttons in loot panel.
	for child in v_box_container.get_children():
		child.queue_free()
