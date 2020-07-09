extends Button

export(PackedScene) var level

# Change level if not null
func _on_Button_pressed():
	if (level != null):
		get_tree().change_scene(level.get_path())

