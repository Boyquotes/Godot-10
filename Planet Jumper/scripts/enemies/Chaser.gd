extends "res://scripts/enemies/Enemy.gd"

export(float) var speed = 100

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	# Rotation
	look_at(player.get_global_position())
	rotate(PI/2)
	pass

func _integrate_forces(state):
	var direction = (player.get_global_position() - get_global_position()).normalized()
	set_linear_velocity(direction*speed)
	pass