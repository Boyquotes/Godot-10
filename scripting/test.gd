extends Node

class_name ScriptName

func _ready():
    var this = ScriptName           # reference to the script
    var dank = Sprite.new()   # new instance of a class named MyCppNode

    dank.queue_free()