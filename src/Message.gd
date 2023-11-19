extends Command
class_name Message

@onready var label : RichTextLabel = $Label
var offset = 15

func set_text(val : String):
	label.text = val
	size.y = label.get_content_height()
	custom_minimum_size.y = label.get_content_height()
	#size.y = label.get_line_count() * label.get_line_height()
	#custom_minimum_size.y = label.get_line_count() * label.get_line_height()
	
