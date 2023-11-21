extends VBoxContainer

var input = preload("res://src/Scenes/Console/Input.tscn")
var false_input_instance = preload("res://src/Scenes/Console/FalseInput.tscn")
var message = preload("res://src/Scenes/Console/Message.tscn")
var environment = preload("res://src/Scenes/Console/3DConsoleBackground.tscn")


#Connect the enter command to commands container
func _ready():
	for c in self.get_children():
		assert(c is Command)
		var command = c as Command
		command.enter_command.connect(enter_command)
	StoryManager.display_text.connect(show_story)
	Signals.show_cutscene.connect(show_cutscene)
	Signals.show_end_screen.connect(show_end_screen)
	

#Enter the current command typed out and parses the contents
func enter_command(message : String):
	var args = message.split(" ")
	var instance : Command 
	
	#Starts the games
	if (args[0].to_lower() == "start" && !Global.start):
		Global.start = true
		StoryManager.continue_story("start")
		return
	
	if !Global.start:
		self.add_child(create(input))
		return
	
	if (handle_commands(args)):
		return 
		
	
	var has_options = StoryManager.choices_dict.size() > 0 and StoryManager.choices_dict.has(args[0].to_lower())
	var id = StoryManager.choices_dict[args[0].to_lower()] if has_options else null
	
	if (id != null):
		StoryManager.continue_story(id)
		
	elif (args[0] == "c"):
		StoryManager.continue_story()
		
	elif (Global.can_continue):
		self.add_child(create(input))
		
#Handles commands that are outside of dialogue and choices
func handle_commands(args):
	match(args[0].to_lower()): 
		"cls":
			clear()
			self.add_child(create(input))
			return true
			
		"jump":
			StoryManager.continue_story(args[1])
			return true
			
	return false

func test():
	#Add message to console
	var message_instance : Message = message.instantiate() as Message
	self.add_child(message_instance)
	message_instance.set_text("This is a test for the consoles response.")
	message_instance.enter_command.connect(enter_command)
	
	#Add input to console
	self.add_child(create(input))

#Wish there was function overloading
func show_story(text : String, has_input := true, false_input : String = ""):
	#Add message to console
	var message_instance : Message = message.instantiate() as Message
	self.add_child(message_instance)
	message_instance.set_text(text)
	message_instance.enter_command.connect(enter_command)
	
	#Adds an input that we can't control whats entered
	if (false_input != ""):
		var instance = false_input_instance.instantiate()
		instance.enter_command.connect(enter_command)
		instance.text = false_input
		self.add_child(instance)
		return
	
	#If it detects a pause, it doesn't create a new input
	if (has_input):
		self.add_child(create(input))
		

func show_cutscene(path : String, ascii_x = 8, ascii_y = 16):
	var instance : ConsoleImage = environment.instantiate() as ConsoleImage
	instance.enter_command.connect(enter_command)
	self.add_child(instance)
	instance.add_scene.call_deferred(path, ascii_x, ascii_y)
		
func show_end_screen(path : String):
	Global.start = false
	var screen = load(path)
	self.add_child(create(screen))
	self.add_child(create(input))
	pass

	
func create(scene : PackedScene):
	var instance : Command = scene.instantiate() as Command
	instance.enter_command.connect(enter_command)
	return instance

#Clear console
func clear():
	for c in self.get_children():
		c.queue_free()
