extends Node3D
@export var player: CharacterBody3D
var isAlive: bool = false
var currentFrame = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$AnimationPlayer.play("walkdeath")
	
	
func persuit(frame: int, draw: int, offset: int, speed: float)->void:
	if isAlive and (frame%(draw)-offset) == 0:
		look_at(player.global_position)
		if global_position.distance_to(player.global_position) > 1.5:
			global_position += -global_transform.basis.z.normalized()*speed
		else:
			global_position += global_transform.basis.z.normalized()*3.
			player.lifes -= 1
			$AudioStreamPlayer3D2.play(0.0)
			player.getHit()
	else: return

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#++currentFrame
	#persuit(currentFrame, 3, 0, .05)
	
func _on_area_3d_body_entered(body):	
	visible = false
	var ballHitSound: AudioStreamPlayer3D = $AudioStreamPlayer3D
	if isAlive: ballHitSound.play(0)
	isAlive = false
	body.queue_free()
	global_position.y = -100
