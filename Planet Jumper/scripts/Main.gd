extends Node

# When enemy collides with the player, main calls this function
func _on_Player_win_condition(is_won):
	if (is_won):
		$HUD.show_clear_level()
	else:
		$HUD.show_game_over()
