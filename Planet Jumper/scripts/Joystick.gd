extends Sprite
 
# Get the radius of the circle
onready var radius = ($JoystickButton.normal.get_height()/2) * $JoystickButton.scale.y
onready var boundary = (texture.get_height()/2) * scale.y

func _input(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		$JoystickButton.set_global_position(event.position - Vector2(radius, radius)) # Position button in the middle of finger pressed.

	# If the JoystickButton is outside the boundary, force the position to boundary
	if get_button_pos().length() > boundary: 
		$JoystickButton.set_position((get_button_pos().normalized() * boundary) - Vector2(radius, radius)) 
	
# Get the position of middle of the button relative to parent
func get_button_pos():
	return $JoystickButton.position + Vector2(radius, radius) # radius is positioning the button in the middle of the image