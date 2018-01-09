extends Node

var Test = preload("test_node.gd")

var test_1
var test_2

func _ready():
	set_process(true)
	test_1 = Test.new()
	test_1.message = "1"
	test_2 = Test.new()
	test_2.message = "2"
	
	add_child(test_1)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "timeout")
	timer.set_wait_time(1)
	timer.start()

func timeout():
	print("change")
	if (test_1.get_parent() == null):
		remove_child(test_2)
		add_child(test_1)
	else:
		remove_child(test_1)
		add_child(test_2)
