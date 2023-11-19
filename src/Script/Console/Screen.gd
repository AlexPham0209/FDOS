extends Sprite2D

@onready var viewport = $"../SubViewportContainer/Viewport"

func _process(delta):
	var texture = viewport.get_texture()
	self.texture = texture
