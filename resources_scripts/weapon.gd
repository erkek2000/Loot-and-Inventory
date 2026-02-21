extends Resource
class_name Weapon


@export var name: String
#@export var icon: Texture2D

## Minimum Damage Value
@export var damage_min: int = 0
## Maximum Damage Value
@export var damage_max: int = 0

## Weapon Attack Speed
@export var speed: float = 1
## Weapon Crit Chance. 0.01 is 1% crit chance.
@export var crit_chance: float = 0.01
## Weapon Crit Damage. Default is 2 times the normal damage.
@export var crit_damage: float = 2
## Weapon Knockback Value
@export var knockback: float = 1
@export var lore: String
## 
@export var rarity: int = 1
@export var spawn_weight: int = 1
## Check if this item is in a recipe.
@export var is_material: bool = false
