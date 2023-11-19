extends Node3D

func _process(delta):
	if Input.is_action_pressed("left"):
		self.rotate_y(-1.0 * delta)
	if Input.is_action_pressed("right"):
		self.rotate_y(1.0 * delta)
