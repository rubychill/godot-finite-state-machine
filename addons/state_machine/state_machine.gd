#####
# State Machine
# -- Usage --
# States are any nodes set as children to this one in the scene, or added with the add_state(state) function.
# The default state is the first child of the state machine, or the first one added.
# State nodes process the same way as other nodes, but are removed from the scenetree when they are not active.
# pop_state() and push_state(name) are used to manipulate the stack based implementation of the state machine
# set_state(name) can be used to change the current state (pop_state() followed by push_state(name), without triggering new states between them)
#
# Some notes:
#	The parent of a state is guaranteed to be the state machine
#	States can remove themselves as the current state by referencing the state machine, but be aware that the node is immediately removed from the SceneTree (akin to free())
#	States can have child nodes, and they will act as intended when the state is not active
#	_ready() is called on a state every time it is activated, use _init() for anything that can *only* be called once
#	Maybe also learn about when _init() and _ready() are called in general, it's good to know anyway
#####
extends Node

# member vars
var current_state = null setget set_current_state, get_current_state # reference to current state
var _stack = [] setget set_stack, get_stack
var _states = {} setget set_states # dictionary of state names to state nodes
var _history = [] setget set_history# list of the previous states used
export(int) var history_length = 10 # length of the history that is saved

# signals
signal state_changed(state)
signal state_added(state)

func _ready():
	# initialise the stack with an empty element
	_stack.push_front(null)

func add_children_as_states():
	for child in get_children():
		add_state(child)

func add_state(state):
	emit_signal("state_added", state)
	print("Adding state %s" % state.get_name())
	# error checking
	if (_states.has(state.get_name())):
		print("ERROR: new state has name that already exists in state machine")
		return
	# add the state to the dictionary and as child, emit signal
	_states[state.get_name()] = state
	# remove the state from its parent
	if (state.get_parent() != null):
		state.get_parent().remove_child(state)
	# if there is no current state, set to this one
	if (current_state == null):
		set_state(state.get_name())

func set_state(value):
	print("Setting state to %s" % value)
	value = str(value)
	if (!_states.has(value)):
		print("ERROR: State machine does not contain state: %s" % value)
		return
	# end the current state if it exists
	if (current_state != null):
		_history.push_front(current_state.get_name())
		if (_history.size() > history_length):
			_history.pop_back()
		# remove child
		remove_child(current_state)
	# set the new state and start it
	current_state = _states[value]
	_stack[0] = _states[value]
	add_child(current_state)
	emit_signal("state_changed", current_state)

func has_state(state_name):
	return _states.has(state_name)

# pop front of stack, and set state to the new head
func pop_state():
	_stack.pop_front()
	set_state(_stack[0].get_name())

# push an empty element to the front of the stack, then set the new state to fill it
func push_state(name):
	_stack.push_front(null)
	set_state(name)

func set_current_state(value):
	print("ERROR: Can't modify current state directly, use set_state(name) instead")

func get_current_state():
	return current_state

func set_states(value):
	print("ERROR: Can't modify states directly, add with add_state(state) instead")

func set_stack(value):
	print("ERROR: Can't modify state stack")

func get_stack():
	print("ERROR: Can't modify state stack")

func set_history(value):
	print("ERROR: Can't modify state history")