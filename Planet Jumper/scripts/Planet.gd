extends RigidBody2D

export var target_planet = false
onready var radius = ($Sprite.texture.get_height()/2) * $Sprite.scale.x * 2