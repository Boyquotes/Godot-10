extends RigidBody2D

export(float) var max_speed = 100
export(float) var max_force = 1

func _integrate_forces(state):
	seek()
	
func seek():
	var player_loc = get_parent().get_node("Player").get_global_position() # Probalby need a better way to find this
	var desired = (player_loc - get_global_position()).normalized()
	desired *= max_speed
	 
	var steer = desired - get_linear_velocity()
		
	apply_central_impulse(limit(steer, max_force))
	
func limit(steer_velocity, max_magnitude):
	var steer_magnitude = sqrt(pow(steer_velocity.x, 2) + pow(steer_velocity.y, 2))
	var ratio = max_magnitude/steer_magnitude
	
	return steer_velocity*ratio 