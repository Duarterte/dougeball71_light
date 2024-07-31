extends Node3D
var zombieNode = preload("res://characters/zomby.tscn")
var zombies: Array[Node3D]
var aliveZombies: Array[Node3D]
@export var player: CharacterBody3D
@onready var currentFrame = 0
@onready var currentZombieIteration: int = 0
const NUMBEROFZOOMBIES = 31


func instansiateZombies():
	var zombiInstance: Node3D = zombieNode.instantiate()
	zombiInstance.player = player
	add_child(zombiInstance)
	zombiInstance.global_position = Vector3(0, -10, 0)
	#instance_from_id(zombiInstance.get_instance_id()).visible = true
	zombies.append(zombiInstance)

func zombWrapper(zombPer: Callable):
	zombPer.call_deferred()	
	
func _ready():
	for i in range(1,NUMBEROFZOOMBIES):
		instansiateZombies()

func _process(delta):
	currentFrame += 1
	for i in range(aliveZombies.size()):
		aliveZombies[i].persuit(currentFrame, 3, i%3, .15)
		
func _on_timer_timeout():
	var zmb: Node3D = zombies[currentZombieIteration]
	if not zmb.isAlive:
		if is_instance_valid(aliveZombies.find(zmb)): aliveZombies.erase(aliveZombies.find(zmb))
		zmb.isAlive = true
		zmb.global_position = Vector3(randf_range(-31.5, 31.5), 0., randf_range(-31.5, 31.5))
		zmb.visible = true
		aliveZombies.append(zmb)
	if currentZombieIteration < NUMBEROFZOOMBIES-2: currentZombieIteration += 1
	else: currentZombieIteration = 0 