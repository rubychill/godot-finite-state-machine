extends Node

onready var fsm = get_node("StateMachine")

func _ready():
	fsm.connect("state_added", self, "state_added")
	fsm.connect("state_changed", self, "state_changed")
	
	fsm.add_children_as_states()
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "timeout")
	timer.set_wait_time(1)
	timer.start()

func timeout():
	if (fsm.current_state.get_name() == "State1"):
		fsm.set_state("State2")
	else:
		fsm.set_state("State1")

func state_added(state):
	print("Connecting")
	state.connect("test", self, "test")

func state_changed(state):
	pass

func test(node):
	print("Signal %s" % node.get_name())