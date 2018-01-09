extends Node

const Test = preload("test_node.gd")
onready var fsm = get_node("StateMachine")

var test_1
var test_2

func _ready():
	set_process(true)
	test_1 = Test.new()
	test_1.message = "1"
	test_1.set_name("test1")
	test_2 = Test.new()
	test_2.message = "2"
	test_2.set_name("test2")
	
	fsm.add_state(test_1)
	fsm.add_state(test_2)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "timeout")
	timer.set_wait_time(1)
	timer.start()

func timeout():
	print("change")
	if (fsm.current_state.get_name() == "test1"):
		fsm.set_state("test2")
	else:
		fsm.set_state("test1")
