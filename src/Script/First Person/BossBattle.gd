extends Cutscene

@onready var player = $Player

func _ready():
	for child in self.get_children():
		if (child is Exit):
			child.end_scene.connect(on_end_scene)
			

func _unhandled_input(event):
	player._unhandled_input(event)

func on_end_scene(title : String):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	leave.emit(title)
