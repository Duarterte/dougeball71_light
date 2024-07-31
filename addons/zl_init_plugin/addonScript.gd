@tool
extends Control
@onready var btn: Button =  $Button
@onready var rootDir := DirAccess.open("res://")

signal playerScriptReady

func rescanFiles() -> void:
	var fs: EditorFileSystem = EditorInterface.get_resource_filesystem()
	fs.scan()

func _on_http_request_request_completed(result, response_code, headers, body):
	var file = FileAccess.open("res://characters/playerScript.gd", FileAccess.WRITE)
	file.store_string(body.get_string_from_utf8())
	file.close()
	playerScriptReady.emit()

func _on_button_pressed():
	if not rootDir.dir_exists("assets"):
		rootDir.make_dir("assets")
		rootDir.make_dir("assets/textures")
		rootDir.make_dir("assets/sound")
		rootDir.make_dir("characters")
		rootDir.make_dir("characters/textures")
		rootDir.make_dir("characters/sounds")
		rootDir.make_dir("world")
		rootDir.make_dir("world/textures")
		rootDir.make_dir("world/sounds")
		rescanFiles()
	else:
		printerr("folder already exist")

func _on_first_person_char_pressed():
	var http = 	$HTTPRequest
	if not rootDir.file_exists("characters/player.tscn"):
		http.request("https://raw.githubusercontent.com/Duarterte/firstPlayerScript/main/playerScript")	
		await playerScriptReady
		var player   := CharacterBody3D.new()
		var camera 	 := Camera3D.new()
		var mesh     := MeshInstance3D.new()
		var collider := CollisionShape3D.new()
		var script   := load("res://characters/playerScript.gd")
		player.name = "Player"
		camera.name = "PlayerCamera"
		camera.position = Vector3(0, 1.5, -.4)
		mesh.name   = "PlayerMesh"
		mesh.position = Vector3(0, 1, 0)
		mesh.mesh = CapsuleMesh.new()
		collider.name = "PlayerMeshCollider"
		collider.position = Vector3(0, 1, 0)
		collider.shape = mesh.mesh.create_convex_shape(true, true)
		player.add_child(camera)
		player.add_child(mesh)
		player.add_child(collider)
		camera.owner   = player
		mesh.owner     = player 
		collider.owner = player
		player.set_script(script)
		var scn    := PackedScene.new()
		var result := scn.pack(player)
		if result == OK:
			var error = ResourceSaver.save(scn, "res://characters/player.tscn")
			if error != OK:
				push_error("An error occurred while saving the scene to disk.")
			rescanFiles()
	else:
		printerr("file already exist")
	


	
