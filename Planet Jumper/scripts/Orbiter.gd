extends KinematicBody2D

# Variable initialization
var parent_planet
var rand_rotation = 0.01

# Run on start up
func _ready():
	parent_planet = self.get_parent()
	
	# Determine the direction of enemy rotation
	if (randi()%2 == 0):
		rand_rotation *= -1

# Run on every physics process
func _physics_process(delta):
	rotate_enemy()

# Rotate enemy in a rand direction (counter or clockwise)
func rotate_enemy():
	rotate_around(parent_planet.get_global_position(), self.global_position, rand_rotation)

# Func to rotate around an origin
func rotate_around(origin, player_pos, angle):
	var s = sin(angle)
	var c = cos(angle)
	
	player_pos.x -= origin.x
	player_pos.y -= origin.y
	
	var new_x = player_pos.x * c - player_pos.y * s
	var new_y = player_pos.x * s + player_pos.y * c
	
	global_position.x = new_x + origin.x
	global_position.y = new_y + origin.y