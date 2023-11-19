extends Control

@export_file("*.dialogue") var file: String

@onready var animation_player = $AnimationPlayer
var is_inverted = false

func _ready():
	StoryManager.load_story(file)
	Signals.invert_colors.connect(invert_colors)

#Inverts the colors of the console
func invert_colors():
	is_inverted = !is_inverted
	
	#Inverts the screen if it is not inverted.  If it is inverted, turn back to normal
	if (is_inverted):
		animation_player.play("Invert")
		return
	animation_player.play_backwards("Invert")
	
