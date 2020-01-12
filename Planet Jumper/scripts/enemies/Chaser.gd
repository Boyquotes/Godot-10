extends "res://scripts/enemies/Enemy.gd"

export(float) var max_speed = 1.75 
export(float) var max_force = 0.25
export(float) var max_see_ahead = 100
export(float) var max_avoid_force = 100

onready var player = get_parent().get_node("Player")
var planet_list: Array

# Vector initializations
var ahead = Vector2()
var ahead2 = Vector2()
var steering = Vector2()

# Test variables
var ahead_draw = Vector2(0, 0)
var ahead2_draw = Vector2(0, 0)
var avoid_draw = Vector2(0, 0)

func _process(delta):
	update()
	pass

func _physics_process(delta):
	steering = Vector2()
	steering = steering + seek()
	steering = steering + collision_avoidance()

	steering = steering.clamped(max_force)
	steering = steering / mass

	var velocity = linear_velocity + steering
	linear_velocity = velocity.clamped(max_speed)
	global_position = global_position + linear_velocity
	
	# Rotation
	look_at(ahead)
	rotate(PI/2)
	
	pass

func _ready():
	var node_list = get_parent().get_children()
	
	# Get list of all planet global coordinates
	for i in range(node_list.size()):
		if (node_list[i].get_class() == "RigidBody2D"):
			if (node_list[i].get_collision_layer_bit(1)):
				planet_list.push_back(node_list[i])

func _integrate_forces(state):
#	steering = Vector2()
#	steering = steering + seek()
#	steering = steering + collision_avoidance()
#
#	steering = steering.clamped(max_force)
#	steering = steering / mass
#
#	var velocity = linear_velocity + steering
#	linear_velocity = velocity.clamped(max_speed)
#	global_position = global_position + linear_velocity
	
#	set_global_position(get_global_position() + get_linear_velocity())
#	apply_central_impulse(steering.clamped(max_speed))
	
#	apply_central_impulse(limit(seek() + collision_avoidance(), max_force)) # Impplement a seeking behavior while avoiding collision with planets.
#	rotate(get_linear_velocity().angle() + PI/2) # Make sure the sprite points towards the player target
	pass

# Function to seek player
func seek():
	var player_loc = player.get_global_position()
#	var player_loc = get_global_mouse_position() # Test variable to get mouse's position
	
	# Get the desired velocity towards the player
	var desired = (player_loc - get_global_position()).normalized()
	desired *= max_speed
	 
	var steer = desired - get_linear_velocity()
		
	return steer
	
# Function to avoid collisions with the planet
func collision_avoidance():
	var dynamic_length = get_linear_velocity().length() / max_speed # Used for prevening collision when maneuvering. 
	ahead = get_global_position() + get_linear_velocity().normalized() * max_see_ahead * dynamic_length
	ahead2 = get_global_position() + get_linear_velocity().normalized() * max_see_ahead * 0.5 * dynamic_length
	
#	if (dynamic_length > 0.9):
#		print ("dynamic_length: ", dynamic_length)
#		print ("ahead w/ dynamic_length: ", ahead)
#		print ("ahead w/out dynamic_length: ", get_global_position() + get_linear_velocity().normalized() * max_see_ahead) 
	
	ahead_draw = ahead # Test variable
	ahead2_draw = ahead2 # Test variable
	
	# Finds the nearest most threatening obstacle
	var most_threatening = find_most_threatening_obstacle()
	var avoidance = Vector2(0, 0)
	
	# Give force to avoidance variable depending on the location of the nearest obstacle
	if (most_threatening != null):
		avoidance = ahead - most_threatening.get_global_position()
		avoidance = avoidance.normalized() * max_avoid_force
	else:
		avoidance *= 0
	
	avoid_draw = avoidance # Test variable
	
	return avoidance
	
# Function to find the most threatening obstacle
func find_most_threatening_obstacle():
	var most_threatening = null
	
	# Looks through the list of planets and determine which planet intersects with ahead and ahead2 vectors
	for i in range(planet_list.size()):
		var obstacle = planet_list[i]
		
		var collision = lineIntersecsCircle(ahead, ahead2, obstacle)
		
		# Compares which obstacle is the most threaning and replaces it if finds a new most threatening obstacle
		if (collision && (most_threatening == null || distance(get_global_position(), obstacle.get_global_position()) < distance(get_global_position(), most_threatening.get_global_position()))):
			most_threatening = obstacle
	
	return most_threatening
	
# Checks to see if there is an intersection between the ahead vectors and the obstacle
func lineIntersecsCircle(ahead, ahead2, obstacle):
	var obstacle_position = obstacle.get_global_position()
	
	# TODO In order to improve this, I might need different points of the enemy sprite so if one point/edge interacts with the planet it can have more accurate collision response
	var enemy_position = distance(obstacle_position, get_global_position()) <= obstacle.radius # Used for applying avoidance force when enemy is inside the radius. Need to put it in the if statement below.
	
	if (distance(obstacle_position, ahead) <= obstacle.radius || distance(obstacle_position, ahead2) <= obstacle.radius || enemy_position):
		return true
		
	# Test statement
#	if (enemy_position):
#		print ("Hit")
#		return true
	
# Euclidean distance formula
func distance(a, b):
	return sqrt(pow(a.x-b.x, 2) + pow(a.y-b.y, 2))
	
# Help function that will tell me the vector length
func _draw(): # NOT AN ACCURATE BECAUSE IT TAKES IN SELF!
#	if (ahead_draw):
#		draw_line(Vector2(0, 0), ahead_draw - get_global_position(), Color( 0, 1, 1, 1 ))
#		draw_line(Vector2(0, 0), ahead2_draw - get_global_position(), Color( 0, 0, 0, 1 ))
#		draw_line(Vector2(0, 0), avoid_draw, Color( 0.86, 0.08, 0.24, 1 ))
	pass