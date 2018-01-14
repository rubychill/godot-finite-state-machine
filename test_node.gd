extends Node

signal test(node)

func _ready():
	set_process(true)

func _process(delta):
	print("Process %s" % get_name())
	emit_signal("test", self)
