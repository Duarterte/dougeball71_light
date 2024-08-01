extends MeshInstance3D
@onready var player: CharacterBody3D = $"../Player"

func _process(delta):
	global_position = Vector3(player.global_position.x, 0, player.global_position.z)
	var material := get_active_material(0)
	material.set("shader_parameter/playerPos", player.global_position*.03)
