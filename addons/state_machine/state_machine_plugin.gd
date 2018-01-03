tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("State Machine", "Node", preload("state_machine.gd"), preload("fsm_icon.png"))
	add_custom_type("State", "Node", preload("state.gd"), preload("state_icon.png"))

func _exit_tree():
	remove_custom_type("State Machine")
	remove_custom_type("State")
