extends RigidBody2D

var thrust = Vector2(0, 250)
var torque = 20000

# Called when the node enters the scene tree for the first time.
func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		applied_force = thrust.rotated(rotation)
	else:
		applied_force = Vector2()
	var rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	applied_torque = rotation_dir * torque

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
