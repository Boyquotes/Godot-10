extends RigidBody2D # Should be StaticBody but will keep it as is for now.

export(float) var delay = 2
onready var bullet = preload("res://scenes/enemies/Bullet.tscn")
onready var player = get_parent().get_node("Player")

onready var timer
onready var radius = ($Sprite.texture.get_height()/2) * $Sprite.scale.y

func _ready():
	# Create a Timer node and connect the timeout signal to self. Once the Timer times out, call function listed.
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	# Set the wait time based on delay var and then add Timer as a child of self. Start the Timer.
	timer.set_wait_time(delay)
	add_child(timer)
	timer.start()

func _physics_process(delta):
	# Make the Cannon face the Player
	look_at(player.get_global_position())
	rotate(-PI/2)
	
# Fire the bullet once the Timer sends out the "timeout" signal.
func _on_timer_timeout():
	# Create an instance of the bullet and position the bullet at Position2D of the Cannon
	var bullet_inst = bullet.instance()
	get_node("/root/Main").add_child(bullet_inst)
	bullet_inst.set_global_position($Position2D.get_global_position())

# Test function for drawing the collision area
func _draw():
	draw_circle(Vector2(), radius, "#ffb2d90a")