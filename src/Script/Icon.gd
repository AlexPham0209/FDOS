extends Sprite2D

func _physics_process(delta):
	self.position = get_global_mouse_position()
