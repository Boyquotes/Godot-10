extends Button

export(PackedScene) var level

func _on_Button_pressed():
	print (level.get_path())
	get_tree().change_scene(level.get_path())
	
