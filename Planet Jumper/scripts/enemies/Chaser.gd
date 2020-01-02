"""
MAKE SURE TO COMMENT ALL THE CODES!
"""

extends "res://scripts/enemies/Enemy.gd"

export(float) var max_speed = 100 
export(float) var max_force = 1 
export(float) var max_see_ahead = 2
export(float) var max_avoid_force = 2
var planet_list: Array

func _ready():
	var node_list = get_parent().get_children()
	
	# Get list of all planet global coordinates
	for i in range(node_list.size()):
		if (node_list[i].get_class() == "RigidBody2D"):
			if (node_list[i].get_collision_layer_bit(1)):
				planet_list.push_back(node_list[i])

func _integrate_forces(state):
	apply_central_impulse(limit(seek() + collision_avoidance(), max_force))
	
func seek():
	var player_loc = get_parent().get_node("Player").get_global_position() # Probalby need a better way to find this
	var desired = (player_loc - get_global_position()).normalized()
	desired *= max_speed
	 
	var steer = desired - get_linear_velocity()
		
	# return limit(steer, max_force)
	return steer
	
func limit(steer_velocity, max_magnitude):
	var ratio = max_magnitude/steer_velocity.length()
	
	return steer_velocity*ratio 
	
func collision_avoidance():
	# var dynamic_length = get_linear_velocity().length() / max_speed # Don't think I will need this. Used for prevening collision when maneuvering. 
	var ahead = position + get_linear_velocity().normalized() * max_see_ahead
	var ahead2 = ahead * 0.5
	
	var most_threatening = find_most_threatening_obstacle(ahead, ahead2)
	var avoidance = Vector2(0, 0)
	
	if (most_threatening != null):
		avoidance = ahead - most_threatening.get_global_position()
		avoidance = avoidance.normalized() * max_avoid_force
	else:
		avoidance *= 0
		
	return avoidance
	
func find_most_threatening_obstacle(ahead, ahead2):
	var most_threatening = null
	for i in range(planet_list.size()):
		var obstacle = planet_list[i]
		var collision = lineIntersecsCircle(ahead, ahead2, obstacle)
		
		if (collision && (most_threatening == null || (distance(get_global_position(), obstacle.get_global_position()) < distance(get_global_position(), most_threatening)))):
			most_threatening = obstacle
	
	return most_threatening
	
func lineIntersecsCircle(ahead, ahead2, obstacle):
	var obstacle_position = obstacle.get_global_position()
	# var enemy_position = distance(obstacle_position, get_global_position()) <= obstacle.radius # Don't think I will need this. Used for applying avoidance force when enemy is inside the radius. Need to put it in the if statement below.
	if (distance(obstacle_position, ahead) <= obstacle.radius || distance(obstacle_position, ahead2) <= obstacle.radius):
		return true
	
func distance(a, b):
	return sqrt(pow(a.x-b.x, 2) + pow(a.y-b.y, 2))