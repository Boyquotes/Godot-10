extends Panel

var enemies

func _ready():
	# Only for immediate children!!! Wow!
	get_node("Button").connect("pressed", self, "_on_Button_pressed") # I can fetch this because it's a child of Panel
	enemies = get_tree().get_nodes_in_group("enemies")

func _on_Button_pressed():
	get_node("Label").text = "Meow"

