extends Node

signal my_signal
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	self.connect("my_signal", self, "_on_test_func")

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("my_signal")

func _on_test_func():
	$Sprite.visible = !$Sprite.visible
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



#func _on_Timer_timeout():
#	$Sprite.visible = !$Sprite.visible
