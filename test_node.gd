extends Node

var message = ""

func _ready():
	set_process(true)

func _process(delta):
	print(message)
