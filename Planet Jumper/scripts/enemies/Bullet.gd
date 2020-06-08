extends RigidBody2D

export(float) var bullet_speed = 1
onready var player = get_parent().get_node("Player")

var inst_flag = false
var direction = Vector2()

func _ready():
	inst_flag = true

func _physics_process(delta):
	# When initially instancing, set the direction and rotation of the bullet.
	if (inst_flag):
		# Make the bullet face the player
		look_at(player.get_global_position())
		rotate(PI/2)
		# Point the bullet to the direction of the player then switch off the flag to prevent direction from updating
		direction = (player.get_global_position() - get_global_position()).normalized()
		inst_flag = false

	# Move the bullet to the player
	set_global_position(get_global_position() + bullet_speed * direction)
	
func _on_VisibilityEnabler2D_screen_exited():
	queue_free()