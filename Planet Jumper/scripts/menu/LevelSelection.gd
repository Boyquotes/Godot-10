extends Control

onready var level_dict = {}

func _ready():
	level_dict = StaticFunc.load_state()
	
	# Change the icon for Level Buttons depending on the level-dict state
	for level in level_dict.keys():
		if (typeof(level_dict[level]) == TYPE_INT and level_dict[level] == 1): # I need this due to "CurrentLevel" and "NextLevel" keys
			get_node("VBoxContainer/MarginContainer/GridContainer/" + level).flat = false # TODO replace this with someting else to indicate that level has already been played.
