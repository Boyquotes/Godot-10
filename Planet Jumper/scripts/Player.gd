extends RigidBody2D

signal jumping

# Variable initializations
var is_attached = false
var attached_planet
var rotation_speed = 10
var jump_speed = 1000.0
	
# Run on physics process
func _physics_process(delta):
	rotate_player(delta)

# Run on input trigger
func _input(event):
	player_jump(event, jump_speed)

# Player jumps away from the planet
func player_jump(input_event, jump_speed):
	if (input_event.is_action_pressed("ui_select") && is_attached):
		# Make the player jump directly above
		var jumpDirection = (self.get_global_position() - attached_planet.get_global_position()).normalized()
		self.set_applied_force(jumpDirection * jump_speed) # Player will carry the momentum of the traveling planet
		
		is_attached = false
		
		# Sends signal to the planet to detach with the player
		emit_signal("jumping", is_attached)

# 1. Move the player around the planet. 2. Make sure the player is oriented correctly while rotating. 3. Let the velocity of player match the planet when position is switched due to rotation
func rotate_player(delta):
	# print("is_attached: ", is_attached)
	if (is_attached):
		var planet_position = attached_planet.get_global_position()
		var planet_velocity = attached_planet.get_linear_velocity()

		# Keyboard input
		if (Input.is_action_pressed("ui_left")):
			# Rotate counterclockwise
			rotate_around(planet_position, self.global_position, -delta*rotation_speed)
		if (Input.is_action_pressed("ui_right")):
			# Rotate clockwise
			rotate_around(planet_position, self.global_position, delta*rotation_speed)
		
		# Reorient the player
		self.look_at(planet_position)
		self.rotate(-PI/2)

		# Set velocity equal to attached planet
		self.set_linear_velocity(planet_velocity)

# Calculation for rotating the object around origin at given angle
func rotate_around(origin, player_pos, angle):
	var s = sin(angle)
	var c = cos(angle)
	
	player_pos.x -= origin.x
	player_pos.y -= origin.y
	
	var new_x = player_pos.x * c - player_pos.y * s
	var new_y = player_pos.x * s + player_pos.y * c
	
	global_position.x = new_x + origin.x
	global_position.y = new_y + origin.y
	

# Indicator when player has collided with a planet. Gets attached planet's data.
func _on_Planet_planet(planet):
	if (!is_attached):
		# print("Planet running")
		self.gravity_scale = 0.0 # Prevents the player from being affected by gravity
		attached_planet = planet # Where attached planet data is derived
		is_attached = true # Simple indicator whether player has collided with a planet
