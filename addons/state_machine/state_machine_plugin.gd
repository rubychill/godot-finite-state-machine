tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("Finite State Machine", "Node", preload("state_machine.gd"), preload("fsm_icon.png"))

func _exit_tree():
	remove_custom_type("Finite State Machine")
