extends CanvasLayer

func show_game_over():
	$MessageLabel.show()
	
func show_clear_level():
	$MessageLabel.text = "Congratulations!"
	$MessageLabel.show()
