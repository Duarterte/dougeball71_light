extends Control
class_name Menu

@onready var blip : AudioStreamPlayer = MenuSound.get_child(0)
@onready var click: AudioStreamPlayer = MenuSound.get_child(1)

func playClick(joda: PackedScene = null):
	click.play()
func playMenuSounds() -> void:
	for menu_btns: Button in get_tree().get_nodes_in_group("menu_btn"):
		menu_btns.connect("mouse_entered", func():blip.play(0))
		menu_btns.connect("button_up", playClick)
		
