extends MarginContainer

onready var option_flag = false
onready var options_menu = get_parent().get_node("OptionsMenu")

func _physics_process(delta):
	show_options_menu() # Enabled when option_flag is set to true

# When Levels is touched
func _on_Levels_gui_input(event):
	if (event is InputEventScreenTouch and event.is_pressed()):
		print ("Pressed")
		get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")

# Enable the option flag to move and disable
func _on_Options_gui_input(event):
	if (event is InputEventScreenTouch and event.is_pressed()):
		option_flag = true
		disable_buttons()
		set_modulate(Color(1, 1, 1, 0.5))
		
# Disable buttons
func disable_buttons():
	var button_container = $VBoxContainer/HBoxContainer2/VBoxContainer
	button_container.get_node("CenterContainer/Play").disabled = true
	button_container.get_node("CenterContainer2/Levels").disabled = true
	button_container.get_node("CenterContainer3/Options").disabled = true
	
# Enable buttons
func enable_buttons():
	var button_container = $VBoxContainer/HBoxContainer2/VBoxContainer
	button_container.get_node("CenterContainer/Play").disabled = false
	button_container.get_node("CenterContainer2/Levels").disabled = false
	button_container.get_node("CenterContainer3/Options").disabled = false

# Move the options menu
func show_options_menu():
	if (option_flag):
		if (options_menu.position.y < 100):
			options_menu.position.y += 1

# Move back the options menu when it's pressed, reenable the buttons, and change the alpha setting of the Main UI
func _on_BackButton_pressed():
	if (option_flag):
		option_flag = false
		options_menu.position.y = -500
		enable_buttons()
		set_modulate(Color(1, 1, 1, 1))
