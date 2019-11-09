extends Node

# Declare member variables here. Examples:
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root() # root is hidden from the scene dock... Scene1 is a child scene of root.
	current_scene = root.get_child(root.get_child_count() - 1) # autoloaded nodes/scenes/whatever getes loaded first so get_child_count() - 1 will get the last child.

func goto_scene(path):
	# you don't want to immediately delete the current scene as the current scene might still be running a vital piece of code 
	# while this function is called (because of asynchronous bs or something like that)... so you wanna defer delete the current scene
	call_deferred("_deferred_goto_scene", path) 

func _deferred_goto_scene(path):
	current_scene.free()
	
	# Load a new scene based on path
	var s = ResourceLoader.load(path)
	
	# Create the instance of the scene (because that's something you have to do... or something like that)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	
	# this is optional...? apparently to make it compatible with the SceneTree.change_scene() API...
	get_tree().set_current_scene(current_scene)