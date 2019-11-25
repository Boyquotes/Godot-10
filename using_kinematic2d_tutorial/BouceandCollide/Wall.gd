extends StaticBody2D

func hit():
	print("Triggers")
	$CollisionShape2D.modulate = Color(0,0,0,0)
	yield(get_tree().create_timer(0.1), "timeout")
	$CollisionShape2D.modulate = Color(255,0,0,255)