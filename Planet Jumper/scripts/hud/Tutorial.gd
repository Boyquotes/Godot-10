extends Control

var tutorials = []
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all the tutorial scenes and put it into tutorials var
	var children = get_children()
	for child in children:
		if (child.get_class() == "ColorRect"):
			tutorials.append(child)
			print (child.name)
	
	# Check if the level has been cleared before. If it has, pause the game. 
	get_tree().paused = true

# Go back to the previous tutorial if it still can. 
func _on_Previous_pressed():
	if (index != 0):
		print ("Pressed Previous")
		tutorials[index].visible = false
		tutorials[index-1].visible = true
		index -= 1

# Go to the next tutorial. If it's the end, pressing it again will unpause the game and make the tutorial screen disappear. 
func _on_Next_pressed():
	if (index != tutorials.size() - 1):
		print ("Pressed Next")
		tutorials[index].visible = false
		tutorials[index+1].visible = true
		index += 1
	else:
		get_tree().paused = false
		queue_free()
