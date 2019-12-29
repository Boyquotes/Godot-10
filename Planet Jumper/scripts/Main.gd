extends Node

""" 
TODO:
	1. Create a HUD scene to display for gameover
	2. Implement a Hit signal for Player.gd when it hits the enemy
	3. Connect game_over() with hit signal
	4. Make enemies 'disappear' when it collides with a planet
""" 

# When enemy collides with the player, main calls this function
func _on_Player_hit():
	$HUD.show_game_over()