extends Node

#onready var planetList = get_tree().get_nodes_in_group("planets") # TODO - Uncomment it once trajectory problem has been figured out
export(PackedScene) var level

# When enemy collides with the player, main calls this function
func _on_Player_win_condition(is_won):
	if (is_won):
		# Show clear level sprite and then move on to the next level
		$HUD.show_clear_level()
		free_enemies()
		yield(get_tree().create_timer(1.5), "timeout")
		
		# Set the level to completed 
		StaticFunc.save_state(name)
		
		# If level is not null, go to the PackedScene level specified. Otherwise, go back to the Main Menu (because it's the end of menu).
		if (level != null):
			get_tree().change_scene(level.get_path())
		else:
			get_tree().change_scene("res://scenes/menu/MainMenu.tscn")
	else:
		$HUD.show_game_over()

# Free enemy nodes
func free_enemies():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
			enemy.queue_free()
