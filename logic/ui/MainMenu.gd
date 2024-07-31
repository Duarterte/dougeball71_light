extends Menu
@onready var gametTilteLabel: Label = $CenterContainer2/GametTitle
@onready var versionLabel: Label = $versionLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	playMenuSounds()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if SGlobal.gameName: gametTilteLabel.text = SGlobal.gameName
	if SGlobal.gameName: versionLabel.text    = SGlobal.version
	if SGlobal.config[SGlobal.FIRSTBOOT]:
		$AnimationPlayer.play("curtainAnim", 0.)
		await get_tree().create_timer(2.).timeout
		remove_child($SceneEntryCurtain)
		SGlobal.config[SGlobal.FIRSTBOOT] = false
	else:
		remove_child($SceneEntryCurtain)
	
func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://logic/ui/settings.tscn")

func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://world/Level1.tscn")
