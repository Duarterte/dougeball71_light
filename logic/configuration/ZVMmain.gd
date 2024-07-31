extends Control
class_name ZVMain
# Called when the node enters the scene tree for the first time.

func _process(delta):
	if SGlobal.config[SGlobal.SHOWFPS]:
		GMenu.get_child(0).text = str(Engine.get_frames_per_second())
	else:
		GMenu.get_child(0).text = ""
