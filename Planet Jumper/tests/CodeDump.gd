"""
extends RigidBody2D



#
#signal planet
#
## Define & initialize variables
#var is_player_attached = false
#var attached_player
#
#func _ready():
#	# Is there a way to move a node from parent being Main to parent being Planet?
#	var pla = (get_parent().get_node("Player"))
#	add_child(pla)
#	print("Dank")
#	pass
#	# get_parent().get_node("Player").connect("jumping", self, "_on_Player_jumping")
#var moved_node = whatever.new()
#parent1.add_node(moved_node)
#
#### Later
#
#var moved_node = parent1.get_node("moved_node_name")
#parent1.remove_node("moved_node_name")
#parent2.add_child(moved_node)
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

### This may cause problems due to the code being unable to distinguish between turning off/on attached planet's gravity vs other planets' gravities that are just encompassed within it
# If the player collides with the planet, disable Area2D's gravity field
#func _on_Planet_body_entered(body):
#	# print("Hello")
#	# print(self.get_child(2).name)
#	self.get_child(2).gravity = 0 # bad idea... better to control one player
#	# attached_player = body # bad idea

# If the player exits the planet's Area2D, turn back the gravity field
#func _on_Area2D_area_exited(area):
#	pass # Replace with function body.

"""