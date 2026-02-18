extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_rarity_color(rarity: int) -> Color:
	match rarity:
		1: return Color(0.4, 0.4, 0.4)      # Common (gray)
		2: return Color(0.2, 0.8, 0.2)      # Uncommon (green)
		3: return Color(0.2, 0.4, 1.0)      # Rare (blue)
		4: return Color(0.6, 0.2, 1.0)      # Epic (purple)
		5: return Color(1.0, 0.5, 0.0)      # Legendary (orange)
		_: return Color.WHITE
