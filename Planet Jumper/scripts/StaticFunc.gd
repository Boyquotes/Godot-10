extends Node

onready var level_dict = {}
onready var state_file = "user://state.save"

# Save state
func save_state(level_name):
	level_dict[level_name] = 1
	
	# Operation to get the name of the next level
	var next_level = int(level_name.substr(5)) + 1 # Remove the first 5 letters (returns 11 of Level11), convert it to int, then add 1
	level_dict["NextLevel"] = "Level" + String(next_level)
	level_dict["CurrentLevel"] = level_name

	var file = File.new()
	file.open(state_file, File.WRITE)
	file.store_var(level_dict)
	file.close()

# Load state
func load_state():
	var file = File.new()
	if file.file_exists(state_file):
		file.open(state_file, File.READ)
		level_dict = file.get_var()
		file.close()

	return level_dict
