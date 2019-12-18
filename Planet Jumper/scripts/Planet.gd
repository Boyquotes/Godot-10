extends RigidBody2D
#
#signal planet
#
## Define & initialize variables
#var is_player_attached = false
#
#func _ready():
#	get_parent().get_node("Player").connect("jumping", self, "_on_Player_jumping")
#
#func _process(delta):
##	print("is_player_attached: ", is_player_attached)
#	check_player_attached(get_colliding_bodies())
#
#	# Emit self to player if player collides with self
#	if (is_player_attached):
#		emit_signal("planet", self)
#
## Check to see if player collision occured if player is not yet attached to self
#func check_player_attached(colliding_bodies):
#	if (colliding_bodies && !is_player_attached):
#		for i in range(0, colliding_bodies.size()):
#			if (colliding_bodies[i].name == "Player"):
#				is_player_attached = true
#				print("check_palyer_attached")
#
## Indicate that player is not attahced to self if the player jumps away
#func check_player_detached(player_is_jumping):
#	if (player_is_jumping):
#		is_player_attached = false
#
#func _on_Player_jumping(is_jumping):
#	print("jumping ran")
#	is_player_attached = false
#