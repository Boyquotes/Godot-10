extends Panel

signal restore_pressed
signal sound_pressed
signal back_button_pressed

onready var is_restore_pressed = false
onready var is_sound_pressed = false
onready var is_back_button_pressed = false

# Switch the sound to on/off 
func _on_Sound_pressed():
	var sound_label = get_node("MarginContainer/VBoxContainer/CenterContainer/Sound/SoundLabel")
	if (sound_label.text == "Sound On"):
		sound_label.text = "Sound Off"
	else:
		sound_label.text = "Sound On"
	emit_signal("sound_pressed")

# Restores purchases
func _on_Restore_pressed():
	emit_signal("restore_pressed") 
	
# Goes back to the main menu
func _on_BackButton_pressed():
	emit_signal("back_button_pressed")
