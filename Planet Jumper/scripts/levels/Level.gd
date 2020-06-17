extends Node

#onready var planetList = get_tree().get_nodes_in_group("planets") # TODO - Uncomment it once trajectory problem has been figured out

# When enemy collides with the player, main calls this function
func _on_Player_win_condition(is_won):
	if (is_won):
		$HUD.show_clear_level()
	else:
		$HUD.show_game_over()
