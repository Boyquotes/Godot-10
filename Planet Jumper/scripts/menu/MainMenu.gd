extends MarginContainer

# When Levels is touched
func _on_Levels_gui_input(event):
	if (event is InputEventScreenTouch and event.is_pressed()):
		print ("Pressed")
		get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")

# Move the dropdown options menu and disable the main menu buttons
func _on_Options_gui_input(event):
	TODO
	pass # Replace with function body.
