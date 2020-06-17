extends Area2D

onready var player
onready var on_enter = false

# Draw a trajectory when the object first enters the field
func _on_Gravity_body_entered(body):
	if (body.name == "Player"):
		player = body
		on_enter = true
		update()

# Erase the trajectory when the player exits
func _on_Gravity_body_exited(body):
	on_enter = false
	update()

# Show the trajectory of the player
func _draw() : draw_trajectory()

# Drawing the trajectory of the player
func draw_trajectory():
	if (on_enter):
		var player_pos = player.get_global_position()
		var player_vel = player.get_linear_velocity()
		
		var T = 2 * player_pos.y / (gravity/100)
		var dt = 0.1
		
		for time in range(1, 20):
			var t = time/100.0
			var ax = gravity/100 * sqrt(pow(player_pos.x, 2) + pow(player_pos.y, 2)) * cos(atan2(player_pos.y, player_pos.x))
			var ay = gravity/100 * sqrt(pow(player_pos.x, 2) + pow(player_pos.y, 2)) * sin(atan2(player_pos.x, player_pos.y))
			var a = Vector2(ax, ay)
			
			var new_pos = Vector2(player_vel.x * t + 0.5 * a.x * pow(t, 2) + player_pos.x, player_vel.y * t + 0.5 * a.y * pow(t, 2) + player_pos.y)
			var new_vel = Vector2((new_pos.x - player_pos.x) / t, (new_pos.y - player_pos.y) / t)
			draw_circle(Vector2(new_pos.x - get_global_position().x, new_pos.y - get_global_position().y), 2, Color(0,0,1))
			draw_circle(Vector2(50,50), 2, Color(0,0,1))
			
			# Update new player_pos and player_vel
			player_pos = Vector2(new_pos.x, new_pos.y)
			player_vel = Vector2(new_vel.x, new_vel.y)
