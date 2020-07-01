extends CanvasLayer

# Game Over sprite will show up if the player dies 
func show_game_over():
	$GameOver.show()
	$Joystick.hide()
	$OptionsButton.hide()
	$JumpButton.hide()
	$InvisiblityBackground.rect_position.y = 0 # Bring down the invisible screen so that it can unpause by being touched
	get_tree().paused = true
	
# Win sprite will show up if the player reaches the goal planet
func show_clear_level():
	$Win.show()

# Pause the game and give options (resume, restart, main menu)
func _on_OptionsButton_pressed():
	$PauseMenu.rect_position.y = 100
	get_tree().paused = true

### PauseMenu calller functions ###
func _on_PauseMenu_restart_pressed():
	$PauseMenu.rect_position.y = -500
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_PauseMenu_resume_pressed():
	$PauseMenu.rect_position.y = -500
	get_tree().paused = false

func _on_PauseMenu_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu/MainMenu.tscn")

### InvisiblityBackground caller functions ###
func _on_InvisiblityBackground_gui_input(event):
	# Unpause the game and reset the current scene
	if (event is InputEventScreenTouch and event.is_pressed()):
		get_tree().paused = false
		get_tree().reload_current_scene()
