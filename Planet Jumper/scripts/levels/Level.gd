extends Node

#onready var planetList = get_tree().get_nodes_in_group("planets") # TODO - Uncomment it once trajectory problem has been figured out
onready var game_over_state = false

# When enemy collides with the player, main calls this function
func _on_Player_win_condition(is_won):
	if (is_won):
		$HUD.show_clear_level()
	else:
		$HUD.show_game_over()
		game_over()

# Pause the game when the game is over and set the gave_over_state to true
func game_over():
	get_tree().paused = true
	yield(get_tree().create_timer(1.0), "timeout")
	print("Timeout Indicator")
	game_over_state = true

# Input event 
func _input(event):
	# If the game is lost, then allow touching of the screen to reset the current level
	if (get_tree().paused == true and game_over_state == true):
		if (event is InputEventScreenTouch):
			get_tree().paused = false
			get_tree().reload_current_scene()
