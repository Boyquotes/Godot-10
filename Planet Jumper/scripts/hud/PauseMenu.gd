extends Panel

signal main_menu_pressed
signal restart_pressed
signal resume_pressed

# Go back to Main Menu
func _on_MainMenu_pressed():
	emit_signal("main_menu_pressed")

# Reload current scene
func _on_Restart_pressed():
	emit_signal("restart_pressed")

# Resume game (unpause)
func _on_Resume_pressed():
	emit_signal("resume_pressed")
