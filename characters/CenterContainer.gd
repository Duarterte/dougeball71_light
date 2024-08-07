extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


func _draw():
	draw_circle(Vector2(0,0), 2., Color(0, 0, 0, .8))

	
