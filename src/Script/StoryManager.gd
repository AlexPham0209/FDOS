extends Node

signal display_text(text : String, has_input : bool, false_input : String)
var resource
var current_dialogue
var choices_dict  : Dictionary

#Loads in the story
func load_story(file : String):
	resource = load(file)	
	
func start_story():
	current_dialogue = await DialogueManager.get_next_dialogue_line(resource, "start")
	display_text.emit(current_dialogue.text)
	
func continue_story(id := str(current_dialogue.next_id)):
	current_dialogue = await DialogueManager.get_next_dialogue_line(resource, id)
	
	if (current_dialogue == null):
		end_story()
		return
	
	var choices = current_dialogue.responses
	
	#Add all choices to a dictionary and clears if its empty
	if choices.size() > 0: 
		for choice in choices:
			choices_dict[choice.text.to_lower()] = choice.next_id
	else:
		choices_dict.clear()
	
	#Checks if there is a pause
	var pause = false if current_dialogue.tags.has("pause") else true
	var false_input = current_dialogue.get_tag_value("falseinput").replace("-", " ") if current_dialogue.get_tag_value("falseinput") != null else ""
	display_text.emit(current_dialogue.text, pause, false_input)
	
		
func end_story():
	print("end")
	
func select_choice(index):
	pass
	#index(index)

