extends Node

### Rigidbody2D Movement ###
#var thrust = Vector2(0, -250)
#var torque = 2000

#func _integrate_forces(state):
#	if Input.is_action_pressed("ui_up"):
#		applied_force = thrust.rotated(rotation)
#	else:
#		applied_force = Vector2()
#	var rotation_dir = 0
#	if Input.is_action_pressed("ui_right"):
#		rotation_dir += 1
#	if Input.is_action_pressed("ui_left"):
#		rotation_dir -= 1
#	applied_torque = rotation_dir * torque

### Check X & Y velocity ###
#func _process(delta):
#	velocity = get_linear_velocity()
#	print("velocity x: ", velocity.x)
#	print("velocity y: ", velocity.y)