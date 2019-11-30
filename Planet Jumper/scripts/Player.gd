extends RigidBody2D

var attached = false

var attached_planet_position = Vector2()
var planet_global_position = Vector2()

# Test Variables
var test_pos # I don't like this... need to clean this up later...
var planet_pos
var player_angle
var distance
var speed

func _ready():
	player_angle = PI/2 # Maybe this needs to be calculated
	planet_pos = get_parent().get_node("Planet").get_position()
	distance = sqrt(pow(get_position().x-planet_pos.x, 2) + pow(get_position().y-planet_pos.y, 2))
	
func _process(delta):
	rotate_player(delta)

func rotate_player(delta):
	# wrong because planet_global_position changes constantly
	if (Input.is_action_pressed("ui_left")):
		# Rotate counterclockwise
		rotate_around(planet_pos, player_angle, distance, delta*-1.0)
	if (Input.is_action_pressed("ui_right")):
		# Rotate clockwise
		rotate_around(planet_pos, player_angle, distance, delta*1.0)

func rotate_around(planet_pos, player_angle, distance, speed):
	player_angle += PI * speed # speed will include delta
	var dx = sin(player_angle) * distance
	var dy = cos(player_angle) * distance
	set_position(planet_pos + Vector2(dx, dy))
	
func _on_Planet_planet_position(position):
	test_pos = position
	
func _integrate_forces(state):
	if (attached):
		look_follow(state, get_global_transform(), attached_planet_position)

# Voodoo magic if this works... damn it! ok voodoo magic
func look_follow(state, current_transform, target_position):
	var cur_dir = current_transform.basis_xform(Vector2(-1,0)) # Need to make it a vector@
	var target_dir = (target_position - current_transform.origin).normalized()
#	print("cur_dir.x", cur_dir.x)
#	print("target_dir.x", target_dir.x)
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
		planet_global_position = body.global_position
	
	if (body.name == "Planet"):
		print("Planet Collision")

# This happens every time... this might be replaced with a global variable
func _on_Planet_planet_velocity(planet_velocity):
	# If the player has made contact (attached == true) to a planet, set the player's velocity equal to the attached planet
	if attached:
		# Setting the player's velocity equal to planet's velocity
		set_linear_velocity(planet_velocity)
