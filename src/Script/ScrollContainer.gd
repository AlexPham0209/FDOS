extends ScrollContainer

@onready var scroll_bar = self.get_v_scroll_bar()

func _ready():
	scroll_bar.changed.connect(on_changed)

func on_changed():
	self.scroll_vertical = scroll_bar.max_value
