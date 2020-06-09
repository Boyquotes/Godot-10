extends RigidBody2D

signal win_condition # When the player wins or loses either by an enemy or reaching the target planet

# Variable initializations
onready var is_attached = false
onready var attached_planet
onready var rotation_dir = 0
export(float) var rotation_speed = 0.02
export(float) var jump_speed = 100.0

var velocity = Vector2() # Test variable
var get_current_pos = Vector2() # Test variable
	
# Run on physics process
func _physics_process(delta):
	orient_and_match_vel()
	rotate_player()
	
	# Test statements
#	player_move_test()

# Run on input trigger
#func _input(event):
#	player_jump(event, jump_speed)

# Test function that moves the players
func player_move_test():
	# Only works if it's in Kinematic mode
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * 3
	get_current_pos = get_global_position()
	set_global_position(get_current_pos + velocity)

# Player jumps away from the planet
func player_jump(jump_speed):
#	if (input_event.is_action_pressed("ui_select") && is_attached):
#		# Make the player jump directly above
#		var jumpDirection = (get_global_position() - attached_planet.get_global_position()).normalized()
#		set_linear_velocity(jumpDirection * jump_speed)
#
#		# Planet rebounds on the opposite direction based on planet's mass
#		mass = 1.00
#		attached_planet.linear_velocity = (attached_planet.get_linear_velocity()*attached_planet.mass - get_linear_velocity()*mass) / attached_planet.mass
#
#		is_attached = false
#		gravity_scale = 1.0
#		attached_planet.get_node("Area2D").set_collision_mask_bit(0, false)
		
	if (is_attached):
		# Make the player jump directly above
		var jumpDirection = (get_global_position() - attached_planet.get_global_position()).normalized()
		set_linear_velocity(jumpDirection * jump_speed)
		
		# Planet rebounds on the opposite direction based on planet's mass
		mass = 1.00
		attached_planet.linear_velocity = (attached_planet.get_linear_velocity()*attached_planet.mass - get_linear_velocity()*mass) / attached_planet.mass
		
		is_attached = false
		gravity_scale = 1.0
		attached_planet.get_node("Area2D").set_collision_mask_bit(0, false)

# 1. Make sure the player is oriented correctly while rotating. 2. Let the velocity of player match the planet when position is switched due to rotation
func orient_and_match_vel():
	if (is_attached):
		var planet_position = attached_planet.get_global_position()
		var planet_velocity = attached_planet.get_linear_velocity()
		
		look_at(planet_position)
		rotate(-PI/2)
	
		# Set velocity equal to attached planet
		set_linear_velocity(planet_velocity)

# Move the player around the planet. 
func rotate_player():
	if (is_attached):
		var planet_position = attached_planet.get_global_position()
		
		# Keyboard input
#		if (Input.is_action_pressed("ui_left")):
#			# Rotate counterclockwise
#			rotate_around(planet_position, get_global_position(), -delta*rotation_speed)
#		if (Input.is_action_pressed("ui_right")):
#			# Rotate clockwise
#			rotate_around(planet_position, get_global_position(), delta*rotation_speed)

		# rotation_dir is updated by _on_Joystick_button_held function
		rotate_around(planet_position, get_global_position(), rotation_dir*rotation_speed)
		rotate_around(planet_position, get_global_position(), rotation_dir*rotation_speed)

# Calculation for rotating the object around origin at given angle
func rotate_around(origin, player_pos, angle):
	var s = sin(angle)
	var c = cos(angle)
	
	var update_pos = Vector2()
	update_pos.x = player_pos.x - origin.x
	update_pos.y = player_pos.y - origin.y
	
	var new = Vector2()
	new.x = update_pos.x * c - update_pos.y * s
	new.y = update_pos.x * s + update_pos.y * c
	
	global_position.x = new.x + origin.x
	global_position.y = new.y + origin.y

# When player collides with other objects
func _on_Player_body_entered(body):
	# If body is a planet, then allow the player to be attached to the plane, else then the player collides with an enemy and emit a hit signal
	if (body.get_collision_layer_bit(1)):
		if (body.target_planet):
			emit_signal("win_condition", true)
		mass = 0.01
		gravity_scale = 0.0 # Prevents the player from being affected by gravity
		
		if (attached_planet):
			attached_planet.get_node("Area2D").set_collision_mask_bit(0, true) # Make sure that previously attached planet's gravity does not affect the player while jumping
		attached_planet = body # Where attached planet data is derived
		is_attached = true # Simple indicator whether player has collided with a planet
	else:
		# Hide the player and set off the collision
		print("hello")
		hide()
		emit_signal("win_condition", false)
		$CollisionShape2D.set_deferred("disabled", true)
	
# If the player is not visible then make it a game over
func _on_VisibilityEnabler2D_screen_exited():
	emit_signal("win_condition", false)

# Whenever the button is pressed, move the Player
func _on_Joystick_button_held(value):
	rotation_dir = value

# If JumpButton is pressed, the Player will jump!
func _on_JumpButton_pressed():
	player_jump(jump_speed)
