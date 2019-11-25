extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn") # A PackedScene!
var speed = 200
var velocity = Vector2()

func get_input():
	# Add these actions in Project Setting -> Input Map...
	velocity = Vector2() # I believe Vector2() gets the current position of the node... No! This resets the velocity so it stops as soon as the key is released!
	if Input.is_action_pressed('backward'):
		velocity = Vector2(-speed/3, 0).rotated(rotation)
	if Input.is_action_pressed('forward'):
		velocity = Vector2(speed/3, 0).rotated(rotation)
	if Input.is_action_just_pressed('mouse_click'):
		shoot()
	
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun...
	var b = Bullet.instance() #PackedScene.instance()
	b.start($Muzzle.global_position, rotation) # Where did the start method come from? It came from the Bullet script! I'm a dumbass!
	get_parent().add_child(b)

func _physics_process(delta):
	get_input()
	var dir = get_global_mouse_position() - global_position # Method in CanvasItem
	# Don't move if too close to the mouse pointer
	if dir.length() > 5:
		rotation = dir.angle()
		velocity = move_and_slide(velocity) # moves due to move_and_slide... is returning velocity necessary? Yeah... it's not really necessary.