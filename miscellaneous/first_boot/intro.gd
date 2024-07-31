extends VideoStreamPlayer
var mainMenuPath 	: String
var mainMenu 	 	: Object
var sceneLoadStatus	: float

func checkIfResoureceIsLoaded(path: String) -> void:
	var sceneLoadStatus = ResourceLoader.load_threaded_get_status(path)
	if sceneLoadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		mainMenu = ResourceLoader.load_threaded_get(path)
		get_tree().change_scene_to_packed(mainMenu)
	else:
		await get_tree().create_timer(.25).timeout
		checkIfResoureceIsLoaded(path)
	
func _ready():
	$AudioStreamPlayer.play(0.)
	mainMenuPath = "res://logic/rootScn.tscn"
	ResourceLoader.load_threaded_request(mainMenuPath)
	

func _on_finished():
	checkIfResoureceIsLoaded(mainMenuPath)
