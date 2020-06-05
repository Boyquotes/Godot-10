extends RigidBody2D

onready var bullet = preload("res://scenes/enemies/Bullet.tscn")
onready var player = get_parent().get_node("Player")

onready var radius = ($Sprite.texture.get_height()/2) * $Sprite.scale.y

func _process(delta):
	# Might have to switch to _physics_process...
	look_at(player.get_global_position())
	rotate(-PI/2)
	if Input.is_action_just_pressed("ui_click"):
		var bullet_inst = bullet.instance()
		# Add direction to bullet
		bullet_inst.face_player(player.get_global_position())
		get_node("/root/Main").add_child(bullet_inst)
		bullet_inst.set_global_position($Position2D.get_global_position())
	pass

func _draw():
	draw_circle(Vector2(), radius, "#ffb2d90a")
	pass