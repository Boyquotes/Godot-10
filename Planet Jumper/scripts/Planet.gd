extends RigidBody2D

signal planet_velocity
signal planet_position

var speed = 200
var velocity = Vector2()
var player_attached = false
	
func _physics_process(delta):
	emit_signal("planet_velocity", get_linear_velocity())
	emit_signal("planet_position", get_global_position())
	
func _process(delta):
	var colliding_bodies = get_colliding_bodies()
	check_player_attached(colliding_bodies)

func check_player_attached(colliding_bodies):
	if (colliding_bodies && !player_attached):
		for i in range(0, colliding_bodies.size()):
			if (colliding_bodies[i].name == "Player"):
				player_attached = true

func check_player_detached(player_is_jumping):
	if (player_is_jumping):
		player_attached = false