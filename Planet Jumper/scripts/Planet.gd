extends RigidBody2D

export var target_planet = false

#var velocity = Vector2() # TODO delete this if it doesn't cause any problems.
onready var radius = ($Sprite.texture.get_height()/2) * $Sprite.scale.y

func _draw():
	draw_circle(Vector2(), radius, "#ffb2d90a")