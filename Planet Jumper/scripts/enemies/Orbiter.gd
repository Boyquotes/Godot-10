extends RigidBody2D

# Variable initialization
export(float) var rotation_velocity = 1
onready var pos_different = get_global_position() - get_parent().get_global_position()

# Run on every process
func _physics_process(delta):
	rotate_enemy()

# Rotate enemy in a rand direction (counter or clockwise)
func rotate_enemy():
#	set_linear_velocity(parent_planet.get_linear_velocity()) # Set it so that the enemy follows the planet
	set_global_position(get_parent().get_global_position() + pos_different) # Set the position of Orbiter
	rotate_around(get_parent().get_global_position(), get_global_position(), rotation_velocity/1000.0) # Rotate the Orbiter
	pos_different = get_global_position() - get_parent().get_global_position() # Recalculate the positional difference

# Func to rotate around an origin
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

# When an object collides with an enemy
func _on_Orbiter_body_entered(body):
	# If it collides with the planet, destroy the enemy
	if (body.get_collision_layer_bit(1)):
		queue_free()
