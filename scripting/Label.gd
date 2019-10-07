extends Label

var accum = 0
var enemies

func _init():
	add_to_group("enemies")

func _ready():
	pass

func _process(delta):
	# accum += delta
	# self.text = str(accum) # text is built in label property
	pass