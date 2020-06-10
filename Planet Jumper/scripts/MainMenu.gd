extends MarginContainer

# When Options is touched
func _on_Options_gui_input(event):
	if (event is InputEventScreenTouch and event.is_pressed()):
		print ("Pressed")
