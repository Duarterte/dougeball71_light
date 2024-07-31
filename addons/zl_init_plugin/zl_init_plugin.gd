@tool
extends EditorPlugin
var ctr: Control
var addonDocket := preload("res://addons/zl_init_plugin/AddonDock.tscn")
func  test():
	print("yes")

func _enter_tree():
	ctr = Control.new()
	var addonFucntionallity = addonDocket.instantiate()
	ctr.add_child(addonFucntionallity)
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BL, ctr)
	
func _exit_tree():
	remove_control_from_docks(ctr)
