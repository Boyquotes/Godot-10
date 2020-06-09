extends Sprite
 
signal button_held(value)

onready var radius = ($JoystickButton.normal.get_height()/2)
onready var boundary = (texture.get_height()/2)
onready var ongoing_drag = -1
onready var return_accel = 20
onready var threshold = 10

func _process(delta):
	if (ongoing_drag == -1):
		# How far the button is from the center. Center - Position of the Button.
		var pos_difference = (Vector2(0, 0) - Vector2(radius, radius)) - $JoystickButton.position
		$JoystickButton.position += pos_difference * return_accel * delta

	emit_signal("button_held", get_value())

func _input(event):
	if (event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed())):
		var event_dist_from_center = (event.position - get_global_position()).length() # Used to calculate the distance between Joystick and the touch event.
		
		if (event_dist_from_center <= boundary * scale.y or event.get_index() == ongoing_drag):
			$JoystickButton.set_global_position(Vector2(event.position.x - radius * scale.x,  position.y - radius * scale.y)) # Position button in the middle of finger pressed and prevent it from going up/down.

			# If the JoystickButton is outside the boundary, force the position to boundary
			if (get_button_pos().length() > boundary): 
				$JoystickButton.set_position((get_button_pos().normalized() * boundary) - Vector2(radius, radius)) 
			
			ongoing_drag = event.get_index()
	elif (event is InputEventScreenTouch and !event.is_pressed()):
		 ongoing_drag = -1
	
# Get the position of middle of the button relative to parent
func get_button_pos():
	return $JoystickButton.position + Vector2(radius, radius) # radius is positioning the button in the middle of the image
	
# Get the value of the button dragged depending on how far it is dragged from 0 - 1
func get_value():
	if (get_button_pos().length() > threshold):
#		print ((get_button_pos()/boundary).x)
		return (get_button_pos()/boundary).x
	return 0