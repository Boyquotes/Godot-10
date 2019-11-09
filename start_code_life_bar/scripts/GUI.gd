extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween
onready var animated_health = 0


func _ready():
	var player_max_health = $"../Characters/Player".max_health # So $ starts inside of the current node where the script is attached. This is why it needs to .. before going into Characters...
	bar.max_value = player_max_health
	# animated_health = player_max_health # this determines whether at the very start you will start with 18 or watch the bar fill up to 18! Duh!!! Makes sense!
	update_health(player_max_health) # 18 at the start

func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value # what an interested... result....

func _on_Player_health_changed(player_health): # so this function gets called whenever the player takes damage which, it turn, calls the update_health() function... makes sense! 
	update_health(player_health)
	
func update_health(new_value):
	# So then... does interpolate_property change the value of the animated_health? I think so... just go with the most likley explanation!
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN) # GUI owns the "animated_health" property so it would reference self... makes sense
	if not tween.is_active():
		# Ok... so it seems like animated_health from 0 is changing to the new_value at the very beginning which will be 18... fukin weird. This means that we can use _ready() to set the initial value of animated_health.
		tween.start() # We only need to activate the tween once and doesn't need to start every single time. 

func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN) # GUI already has its own modulate property. It will change from alpha 1.0 to 0.
