extends Menu
@onready var sensText: LineEdit = $ZVmain/VBoxContainer/MarginContainer3/HSplitContainer/sensText
var sesivityRangeVal: float
func _ready():
	playMenuSounds()
	$ZVmain/VBoxContainer/MarginContainer/HSplitContainer/CheckButton.button_pressed = SGlobal.config[SGlobal.SHOWFPS]
	if SGlobal.config[SGlobal.SENSIVITY]:
		sensText.text = str(SGlobal.configValues[SGlobal.SENSIVITY])
	else:
		sensText.text = str(0.2)
func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://logic/rootScn.tscn")

func _on_check_button_toggled(toggled_on):
	MenuSound.get_child(1).play()
	SGlobal.config[SGlobal.SHOWFPS] = toggled_on
	
	
func _on_h_slider_value_changed(value):
	sesivityRangeVal = value
	sensText.text = str(value)
	
func _on_h_slider_drag_ended(value_changed):
	SGlobal.config[SGlobal.SENSIVITY] = true
	SGlobal.configValues[SGlobal.SENSIVITY] = sesivityRangeVal

func _on_sens_text_text_changed(new_text):
	var sensivity:float = float(new_text)
	if sensivity>0:
		$ZVmain/VBoxContainer/MarginContainer3/HSplitContainer/HSlider.value = sensivity
		SGlobal.config[SGlobal.SENSIVITY] = true
		SGlobal.configValues[SGlobal.SENSIVITY] = sensivity

func _on_sens_text_gui_input(event):
	var mouseClicks:int = 0
	if event.is_action("ui_accept") or event.is_action("ui_cancel"):
			sensText.deselect()
			sensText.release_focus()

func _on_v_box_container_gui_input(event):
	if event is InputEventMouseButton:
		sensText.deselect()
		sensText.release_focus()


func _on_z_vmain_gui_input(event):
	if event is InputEventMouseButton:
		sensText.deselect()
		sensText.release_focus()
