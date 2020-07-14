extends Control

onready var level_dict = {}

func _ready():
	level_dict = StaticFunc.load_state()
	
	# Change the icon for Level Buttons depending on the level-dict state
	var levels = get_tree().get_nodes_in_group("Levels")
	for level in levels:
		if (level_dict.has(level.name) and level_dict[level.name] == 1):
			get_node("VBoxContainer/MarginContainer/GridContainer/" + level.name).flat = false # TODO replace this with someting else to indicate that level has already been played.
