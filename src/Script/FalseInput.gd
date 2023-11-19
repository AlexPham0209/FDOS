extends Command

@onready var message = $Text
@export var text = "test"
var i = 0

func _ready():
	print("init")
	Global.can_continue = false
	self.grab_focus()

func _input(event):
	if (!(event is InputEventKey)):
		return
		
	if (event.is_pressed() && i < text.length()):
		message.text += text[i]
		i += 1
		
	elif (i >= text.length()):
		Global.can_continue = true
		StoryManager.continue_story()
		set_process_input(false)

