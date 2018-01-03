extends Node

var state_machine

func _ready():
	pass

func state_start():
	pass

func state_end():
	pass

func set_name(value):
	printerr("Error: Cannot modify name of state")

func get_name():
	return name