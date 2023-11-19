extends Cutscene

var disable = false
signal stop(title : String)

func _process(delta):
	if (Input.is_action_just_pressed('leave')):
		leave.emit()

func _unhandled_input(event):
	if (event is InputEventKey):
		print(event)


