extends KinematicBody2D

var speed = 750
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal) # normal can be thought of as perpendicularish thing (not exactly but hard to explain)
		if collision.collider.has_method("hit"): # collding object == collider == wall in this case
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # frees up the bullet instance to let the baby relax