extends Area2D

export(float) var bullet_speed = 0.001

var direction = Vector2()

func _physics_process(delta):
	set_global_position(get_global_position() + direction*bullet_speed)
	pass

func face_player(player_pos):
	look_at(player_pos)
	direction = player_pos - get_global_position().normalized()