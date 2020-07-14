extends MarginContainer

onready var option_flag = false
onready var saved_state = null # TODO placeholder for holding onto saved states

func _ready():
	print("not hello")

func _physics_process(delta):
	show_options_menu() # Enabled when option_flag is set to true

# If starting a new game, go through the tutorial. If not, continue where it was left off.
func _on_Play_pressed():
#	saved_state = "res://scenes/levels/Level1.tscn"
#	get_tree().change_scene(saved_state)
	pass

# When Levels is touched
func _on_Levels_pressed():
#	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")
	pass

# Enable the option flag to move and disable
func _on_Options_pressed():
	option_flag = true
	disable_buttons()
	set_modulate(Color(1, 1, 1, 0.5))
	
# Move the options menu
func show_options_menu():
	if (option_flag):
		if (get_parent().get_node("OptionsMenu").rect_position.y < 100):
			get_parent().get_node("OptionsMenu").rect_position.y += 25
	
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

### OptiosnMenu calller functions ###
# Switch the sound to on/off
func _on_OptionsMenu_sound_pressed():
	pass

# Restore purchases
func _on_OptionsMenu_restore_pressed():
	pass # Replace with function body.

# Move back the options menu when it's pressed, reenable the buttons, and change the alpha setting of the Main UI
func _on_OptionsMenu_back_button_pressed():
	if (option_flag):
		option_flag = false
		get_parent().get_node("OptionsMenu").rect_position.y = -500
		enable_buttons()
		set_modulate(Color(1, 1, 1, 1))
