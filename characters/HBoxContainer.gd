extends HBoxContainer
var rootChild: MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(get_children().size()):
		if i < SGlobal.lives:
			get_child(i).get_child(0).visible = true
		else:
			get_child(i).get_child(0).visible = false
