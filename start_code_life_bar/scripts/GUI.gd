extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween

func _ready():
	var player_max_health = $"../Character/Player".max_health # So $ starts inside of the current node where the script is attached. This is why it needs to .. before going into Characters...
	bar.max_value = player_max_health


func _on_Player_health_changed():
	pass # Replace with function body.
