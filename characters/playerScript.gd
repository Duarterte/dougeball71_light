extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var isBallPlaying: bool = false 
var ball = preload("res://assets/ball.tscn")
@onready var playerCamera = $PlayerCamera
@onready var sensivity: float = SGlobal.configValues[SGlobal.SENSIVITY] if SGlobal.config[SGlobal.SENSIVITY] else SGlobal.setSensivity(.2)
var ballInstance: RigidBody3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func getHit():
	var filterEffect: MeshInstance3D = $PlayerCamera/cameraPostProcessing
	var material: Material = filterEffect.get_active_material(0)
	material.albedo_color = Color(1, 0, 0, .5)
	await  get_tree().create_timer(.075).timeout
	material.albedo_color = Color(1, 1, 1, .3)
	await  get_tree().create_timer(.075).timeout
	material.albedo_color = Color(1, 0, 0, .5)
	await  get_tree().create_timer(.075).timeout
	material.albedo_color = Color(1, 1, 1, .3)
	await  get_tree().create_timer(.075).timeout
	material.albedo_color = Color(0, 0, 0, 0)
	
func _ready():
	$PlayerCamera/cameraPostProcessing.get_active_material(0).albedo_color = Color(0, 0, 0, 0)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if SGlobal.config[SGlobal.MUSIC]:
		$Music.play()
	else:
		$Music.stop()
	
func _input(event):
	if event is InputEventMouseMotion	:
		rotate_y(deg_to_rad(-event.relative.x*sensivity))
		#playerCamera.rotate_x(deg_to_rad(-event.relative.y*sensivity))
		playerCamera.rotate_x(deg_to_rad(-event.relative.y*sensivity))
		playerCamera.rotation_degrees.x= clampf(playerCamera.rotation_degrees.x, -45, 33)
	if event.is_action("mainMenu"):
		get_tree().change_scene_to_file("res://logic/ui/MainMenu.tscn")
	if Input.is_action_just_pressed("Throw"):
		isBallPlaying = true
		ballInstance = ball.instantiate()
		get_parent().add_child(ballInstance)
	
		
func _physics_process(delta):
	if SGlobal.lives < 1:
		SGlobal.ZombieNumber = 0
		get_tree().change_scene_to_file("res://logic/rootScn.tscn")
	if ballInstance != null and isBallPlaying and Input.is_action_pressed("Throw"):
		ballInstance.global_position = global_transform.origin+(-global_transform.basis.z.normalized())+(global_transform.basis.y.normalized()*1.45+global_transform.basis.x.normalized()*.5)
		ballInstance.rotation_degrees = rotation_degrees
	if Input.is_action_just_released("Throw"):
		var currentBall = ballInstance
		if is_instance_valid(currentBall): currentBall.global_position = playerCamera.global_position
		if is_instance_valid(currentBall): currentBall.rotation_degrees = playerCamera.rotation_degrees 
		MenuSound.get_child(2).play(0)
		if is_instance_valid(currentBall): currentBall.apply_central_impulse(-(playerCamera.global_transform.basis.z)* 12.5)
		await  get_tree().create_timer(2.).timeout
		if is_instance_valid(currentBall): currentBall.queue_free()
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
