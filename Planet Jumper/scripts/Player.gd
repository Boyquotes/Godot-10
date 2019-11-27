extends RigidBody2D

#var thrust = Vector2(0, -250)
#var torque = 2000
#
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

#var velocity = Vector2()

#func _ready():
#	if (get_mode() != 0):
#		set_mode(0)

#func _process(delta):
#	velocity = get_linear_velocity()
#	print("velocity x: ", velocity.x)
#	print("velocity y: ", velocity.y)
	

# Currently set to Contacts Reported == 1... 1 will be enough... for now.
func _on_Planet_body_entered(body):
	if (body.name == "Player"):
		print("Player Collision")
		
		# Need to make it stop being influenced by gravity... maybe I should let Player send a signal to disable the gravity of Area2D? 
#		if (get_mode() != 3): # DOES NOT WORK! EVEN AFTER IT TURNS TO KINMEATIC, THE DYNAMIC CALCULATION AND ITS COLLISION SHAPE IS STILL CALCULATED! WTF!
#			print("mode = 3")
#			set_mode(3)
	
	
	if (body.name == "Planet"):
		print("Planet Collision")
		
	

