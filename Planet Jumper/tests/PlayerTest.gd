extends RigidBody2D

var origin = Vector2(100, 100)

func _ready():
	print("Origin: (", origin.x, ", ", origin.y, ")")
	print("Player: (", self.global_position.x, ", ", self.global_position.y, ")")

func _physics_process(delta):
	rotate_player(delta)

func rotate_player(delta):
	if (Input.is_action_pressed("ui_left")):
		# Rotate counterclockwise
		rotate_around(origin, self.global_position, delta)
	if (Input.is_action_pressed("ui_right")):
		# Rotate clockwise
		rotate_around(origin, self.global_position, -delta)

func rotate_around(origin, player_pos, angle):
#	var cx = player_pos.x - origin.x
#	var cy = player_pos.y - origin.y
#
#	var new_x = (cx * cos(angle)) - (cy * sin(angle))
#	var new_y = (cy * sin(angle)) + (cx * sin(angle))
#
#	global_position.x = new_x + cx
#	global_position.y = new_y + cy

	var s = sin(angle)
	var c = cos(angle)
	
	player_pos.x -= origin.x
	player_pos.y -= origin.y
	
	var new_x = player_pos.x * c - player_pos.y * s
	var new_y = player_pos.x * s + player_pos.y * c
	
	global_position.x = new_x + origin.x
	global_position.y = new_y + origin.y
	
	print("Angle: ", angle)
	print("New Player: (", self.global_position.x, ", ", self.global_position.y, ")")