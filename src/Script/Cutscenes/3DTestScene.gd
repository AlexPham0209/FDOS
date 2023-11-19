extends Cutscene

@onready var axe = $axe
var disable = false

func _process(delta):
	if disable:
		return
	if Input.is_action_pressed("left"):
		axe.rotate_y(-1.0 * delta)
	if Input.is_action_pressed("right"):
		axe.rotate_y(1.0 * delta)
		
	if (Input.is_action_just_pressed('leave')):
		leave.emit()

func _input(event):
	if (event.is_action_pressed('leave')):
		leave.emit()
		
