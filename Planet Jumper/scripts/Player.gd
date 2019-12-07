extends RigidBody2D

var attached = false

var attached_planet_position = Vector2()
var planet_global_position = Vector2()
	
func _physics_process(delta):
	rotate_player(delta)

func rotate_player(delta):
	# wrong because planet_global_position changes constantly
	if (Input.is_action_pressed("ui_left")):
		# Rotate counterclockwise
		rotate_around(planet_global_position, self.global_position, -delta*10)
	if (Input.is_action_pressed("ui_right")):
		# Rotate clockwise
		rotate_around(planet_global_position, self.global_position, delta*10)

func rotate_around(origin, player_pos, angle):
	var s = sin(angle)
	var c = cos(angle)
	
	player_pos.x -= origin.x
	player_pos.y -= origin.y
	
	var new_x = player_pos.x * c - player_pos.y * s
	var new_y = player_pos.x * s + player_pos.y * c
	
	global_position.x = new_x + origin.x
	global_position.y = new_y + origin.y
	
#	print("Angle: ", angle)
#	print("New Player: (", self.global_position.x, ", ", self.global_position.y, ")")
	
func _on_Planet_planet_position(position):
	planet_global_position = position
	
func _integrate_forces(state):
	if (attached):
		look_follow(state, get_global_transform(), attached_planet_position)

# Voodoo magic if this works... damn it! ok voodoo magic
func look_follow(state, current_transform, target_position):
	var cur_dir = current_transform.basis_xform(Vector2(-1,0)) # Need to make it a vector@
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)
	
	state.set_angular_velocity(rotation_angle / state.get_step())
	
# Currently set to Contacts Reported == 1... 1 will be enough... for now.
func _on_Planet_body_entered(body):
	if (body.name == "Player"):
		print("Player Collision")
		
		# Set the player "attached" to the collided planet
		set_linear_velocity(body.linear_velocity)
		
		# Either disable player to be effected by planet's gravity or disable the gravity of the planet...
		attached = true # This will allow the Player's velocity equal to the planet's velocity at all times.... hopefully...
		gravity_scale = 0.0 # Disable the player's ability to be contracted to gravity
		
		# Reorient the player object to face the correct direction
		attached_planet_position = body.get_global_transform().origin # transform's translation offset == origin??? What does that mean?
	
	if (body.name == "Planet"):
		print("Planet Collision")

# This happens every time... this might be replaced with a global variable
func _on_Planet_planet_velocity(planet_velocity):
	# If the player has made contact (attached == true) to a planet, set the player's velocity equal to the attached planet
	if attached:
		# Setting the player's velocity equal to planet's velocity
		set_linear_velocity(planet_velocity)
