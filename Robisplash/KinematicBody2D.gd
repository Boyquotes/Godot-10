extends KinematicBody2D

# Declare member variables here. Examples:
var run_speed = 250
var jump_speed = -1000
var gravity = 2500

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# colliding(delta)
	sliding(delta)
	
func sliding(delta):
	velocity.y = gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,-1)) # Second argument need to provide the normal direction (in this case up) of the platform.
	
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_just_pressed("ui_select")
	var left = Input.is_action_pressed("ui_left") # I guess boolean
	
	print(is_on_floor())
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func colliding(delta):
	var movement = Vector2(0, 0)
	if Input.is_action_pressed("ui_up"):
		movement = Vector2(0, -300)
	if Input.is_action_pressed("ui_down"):
		movement = Vector2(0, 300)
	if Input.is_action_pressed("ui_right"):
		movement = Vector2(300, 0)
	if Input.is_action_pressed("ui_left"):
		movement = Vector2(-300, 0)
	var collision_info = move_and_collide(movement*delta)
	if collision_info:
		var collision_point = collision_info.position
		print(collision_point) # Works with StaticBody2D but doesn't work with RigidBody2D hmmm