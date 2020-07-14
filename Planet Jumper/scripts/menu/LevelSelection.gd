extends Control

#onready var level_dict = {}
#onready var state_file = "user://state.save"

func _ready():
#	load_state()
	# Change the icon for Level Buttons depending on the level-dict state
#	var levels = get_tree().get_nodes_in_group("Levels")
	print ("Hello")
#	for level in levels:
#		if (level_dict[level.name] == 1):
#			if (get_node("VBoxContainer/MarginContainer/GridContainer/" + level.name) != null):
#				get_node("VBoxContainer/MarginContainer/GridContainer/" + level.name).modulate = Color(1, 1, 1, 1)

# Save state
#func save_state(level_name):
#	level_dict[level_name] = 1
#
#	var file = File.new()
#	file.open(state_file, File.WRITE)
#	file.store_var(level_dict)
#	file.close()

# Load state
#func load_state():
#	var file = File.new()
#	if file.file_exists(state_file):
#		file.open(state_file, File.READ)
#		level_dict = file.get_var()
#		file.close()
#	else:
#		# Set the levels to incomplete if there is no save file
#		var levels = get_tree().get_nodes_in_group("Levels")
#		for level in levels:
#			level_dict[level.name] = 0
