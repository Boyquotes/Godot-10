extends "res://scripts/enemies/Enemy.gd"

export(float) var max_speed = 100 
export(float) var max_force = 1 
export(float) var max_see_ahead = 2
export(float) var max_avoid_force = 2
onready var player = get_parent().get_node("Player")
var planet_list: Array

func _ready():
	var node_list = get_parent().get_children()
	
	# Get list of all planet global coordinates
	for i in range(node_list.size()):
		if (node_list[i].get_class() == "RigidBody2D"):
			if (node_list[i].get_collision_layer_bit(1)):
				planet_list.push_back(node_list[i])

func _integrate_forces(state):
	apply_central_impulse(limit(seek() + collision_avoidance(), max_force)) # Impplement a seeking behavior while avoiding collision with planets.
	rotate(get_linear_velocity().angle() + PI/2) # Make sure the sprite points towards the player target

# Function to seek player
func seek():
	var player_loc = player.get_global_position()
	
	# Get the desired velocity towards the player
	var desired = (player_loc - get_global_position()).normalized()
	desired *= max_speed
	 
	var steer = desired - get_linear_velocity()
		
	return steer
	
# Function to limit how fast the chaser can steer to make it more realistic
func limit(steer_velocity, max_magnitude):
	var ratio = max_magnitude/steer_velocity.length()
	
	return steer_velocity*ratio 
	
# Function to avoid collisions with the planet
func collision_avoidance():
	var dynamic_length = get_linear_velocity().length() / max_speed # Used for prevening collision when maneuvering. 
	var ahead = position + get_linear_velocity().normalized() * max_see_ahead * dynamic_length
	var ahead2 = ahead * 0.5
	
	# Finds the nearest most threatening obstacle
	var most_threatening = find_most_threatening_obstacle(ahead, ahead2)
	var avoidance = Vector2(0, 0)
	
	# Give force to avoidance variable depending on the location of the nearest obstacle
	if (most_threatening != null):
		avoidance = ahead - most_threatening.get_global_position()
		avoidance = avoidance.normalized() * max_avoid_force
	else:
		avoidance *= 0
		
	return avoidance
	
# Function to find the most threatening obstacle
func find_most_threatening_obstacle(ahead, ahead2):
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
	var enemy_position = distance(obstacle_position, get_global_position()) <= obstacle.radius # Used for applying avoidance force when enemy is inside the radius. Need to put it in the if statement below.
	if (distance(obstacle_position, ahead) <= obstacle.radius || distance(obstacle_position, ahead2) <= obstacle.radius || enemy_position):
		return true
	
# Euclidean distance formula
func distance(a, b):
	return sqrt(pow(a.x-b.x, 2) + pow(a.y-b.y, 2))