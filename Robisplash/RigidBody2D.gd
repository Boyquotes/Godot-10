extends RigidBody2D

var rotatation_dir = Vector2()

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

#func _process(delta):
#	var mpos = get_global_mouse_position()
#	look_at(mpos)

func _input(event):
	if event is InputEventMouseButton:
		var mouse_pos = event.position
		print(mouse_pos)

#func look_follow(state, current_transform, target_position):
#	var rotation_angle = 
