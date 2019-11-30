extends RigidBody2D

signal planet_velocity
signal planet_position

var speed = 200
var velocity = Vector2()
	
func _physics_process(delta):
	emit_signal("planet_velocity", get_linear_velocity())
	emit_signal("planet_position", get_global_position())