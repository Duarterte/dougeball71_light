extends Control

var gameName: String = "Dodgeball Seventy-One Ligth"
var version: String  = ""
var firstBoot: bool  = true
var config: Array[bool]
var configValues: Dictionary
var ZombieNumber: int = 0
var lives: int = 5
enum {
	FIRSTBOOT,
	SHOWFPS,
	SENSIVITY,
	MUSIC
}

func initialConfig(numberOfConfigs: int) -> void:
	config.resize(numberOfConfigs)
	config[FIRSTBOOT] = true
	config[SHOWFPS]   = false
	config[SENSIVITY] = false
	config[MUSIC] = true
func _ready():
	initialConfig(4)
	print(gameName + " " + version)
	
func setSensivity(sensv):
	config[SENSIVITY] = true
	configValues[SENSIVITY] = sensv
	return sensv
