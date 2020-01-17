extends RigidBody2D

signal win_condition # When the player wins or loses either by an enemy or reaching the target planet

# Variable initializations
var is_attached = false
var attached_planet
export var rotation_speed = 2
export var jump_speed = 100.0

var velocity = Vector2() # Test variable
var get_current_pos = Vector2() # Test variable
var test_true = false

# Run on start up
func _ready():
	pass
	
func _process(delta):
	show_player()
	pass
	
# Run on physics process
func _physics_process(delta):
	pass
	
	# Test statements
#	player_move_test()

# Run on input trigger
func _input(event):
	pass
#	player_jump(event, jump_speed)
	
func _integrate_forces(state):
	rotate_player(state.step)
	player_jump(jump_speed)
#	if (test_true):
#		set_global_position(attached_planet.get_node("Position2D").get_global_position())
#		test_true = false

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
	
func show_player():
	# Unhide and enable collision for player
#	set_global_position(attached_planet.get_node("Position2D").get_global_position())
	pass

# Player jumps away from the planet
#func player_jump(input_event, jump_speed):
func player_jump(jump_speed):
	if (Input.is_action_pressed("ui_select") && is_attached):
		var muzzle_position = attached_planet.get_node("Position2D").get_global_position()
		var jumpDirection = (muzzle_position - attached_planet.get_global_position()).normalized()
		
		show()
		$CollisionShape2D.set_deferred("disabled", false)
		
		# Make the player jump directly above
		set_linear_velocity(jumpDirection * jump_speed)
		
		# Planet rebounds on the opposite direction based on planet's mass
		mass = 1.00
		attached_planet.linear_velocity = (attached_planet.get_linear_velocity()*attached_planet.mass - get_linear_velocity()*mass) / attached_planet.mass
		
		is_attached = false
		gravity_scale = 1.0
		# attached_planet.get_child(2).set_collision_mask_bit(0, false)
		attached_planet.get_node("Area2D").set_collision_mask_bit(0, false)

# 1. Move the player around the planet. 2. Make sure the player is oriented correctly while rotating. 3. Let the velocity of player match the planet when position is switched due to rotation
func rotate_player(delta):
	if (is_attached):
#		var planet_position = attached_planet.get_global_position()
		var planet_velocity = attached_planet.get_linear_velocity()

		# Keyboard input
		if (Input.is_action_pressed("ui_left")):
			# Rotate counterclockwise
#			rotate_around(planet_position, get_global_position(), -delta*rotation_speed)
			attached_planet.rotate(-delta*rotation_speed) # TODO maybe make it so that player sends signal to the planet and rotate in planet script instead of here
		if (Input.is_action_pressed("ui_right")): 
			# Rotate clockwise
#			rotate_around(planet_position, get_global_position(), delta*rotation_speed)
			attached_planet.rotate(delta*rotation_speed)
		
		# Reorient the player
#		look_at(planet_position)
#		rotate(-PI/2)

		# Set velocity equal to attached planet
		set_linear_velocity(planet_velocity)

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
			
		# Hide the player and disable its collision
#		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		
		if (attached_planet):
			# attached_planet.get_child(2).set_collision_mask_bit(0, true) # Make sure that previously attached planet's gravity does not affect the player while jumping
			attached_planet.get_node("Area2D").set_collision_mask_bit(0, true) # Make sure that previously attached planet's gravity does not affect the player while jumping
		attached_planet = body # Where attached planet data is derived
		is_attached = true # Simple indicator whether player has collided with a planet
		test_true = true
	else:
		# Hide the player and 
		hide()
		emit_signal("win_condition", false)
		$CollisionShape2D.set_deferred("disabled", true)
	
# If the player is not visible then make it a game over
func _on_VisibilityEnabler2D_screen_exited():
	emit_signal("win_condition", false)
