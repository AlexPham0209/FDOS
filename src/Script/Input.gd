extends Command

@onready var message = $InputBar

func _ready():
	$InputBar.grab_focus()

func _on_input_bar_text_submitted(new_text):
	message.editable = false
	message.release_focus()
	enter_command.emit(new_text)
