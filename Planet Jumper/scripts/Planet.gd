extends RigidBody2D

export var target_planet = false

#var velocity = Vector2() # TODO delete this if it doesn't cause any problems.
onready var radius = ($Sprite.texture.get_height()/2) * $Sprite.scale.y

func _ready():
	if (target_planet):
		mode = RigidBody2D.MODE_STATIC

func _draw():
	draw_circle(Vector2(), radius, "#ffb2d90a")
	draw_circle(Vector2(), get_node("Area2D/CollisionShape2D").shape.radius, Color(0.96, 0.96, 0.86, 0.5))
