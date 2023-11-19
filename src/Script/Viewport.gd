extends SubViewport

func _ready():
	set_process_unhandled_input(true)

func _input(event):
	for child in self.get_children():
		if (child is Cutscene):
			child._unhandled_input(event)
