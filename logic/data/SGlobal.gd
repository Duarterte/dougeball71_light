extends Control

var gameName: String = "Dodgeball 71"
var version: String  = "V0.0.2"
var firstBoot: bool  = true
var config: Array[bool]
var configValues: Dictionary

enum {
	FIRSTBOOT,
	SHOWFPS,
	SENSIVITY
}

func initialConfig(numberOfConfigs: int) -> void:
	config.resize(numberOfConfigs)
	config[FIRSTBOOT] = true
	config[SHOWFPS]   = false
	config[SENSIVITY] = false
	
func _ready():
	initialConfig(3)
	print(gameName + " " + version)
	
func setSensivity(sensv):
	config[SENSIVITY] = true
	configValues[SENSIVITY] = sensv
	return sensv
