extends Resource
class_name Armor


@export var name: String
#@export var icon: Texture2D

## Damage Reduction
@export var defence: float

## Wearing armor may slow the player. 1 is unaffected speed.
@export var move_speed: float = 1
## Wearing armor can help against knockback. 1 is no armor knockback.
@export var knockback_resistance: float = 1
## Wearing armor can draw attention. 1 is indifferent attention.
@export var aggro: float = 1

## Armor can be of a faction and can be used as a disguise
@export var is_uniform: bool
@export var uniform_faction: String

@export var lore: String
## Check if this item is in a recipe.
@export var is_material: bool
