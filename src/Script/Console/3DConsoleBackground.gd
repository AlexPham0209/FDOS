extends "res://src/Script/Console/Command.gd"
class_name ConsoleImage

@onready var viewport : SubViewport = $Viewport
@onready var shader : ColorRect = $Viewport/Shader
@onready var sprite : Sprite2D = $Screen
var current_instance : Cutscene


func add_scene(path : String, ascii_x = 8, ascii_y = 16):
	var scene = load(path)
	assert(scene != null)
	viewport.set_update_mode(viewport.UPDATE_ALWAYS)
	current_instance = scene.instantiate()
	current_instance.leave.connect(leave)
	
	#Set ascii size based on parameters
	var material : ShaderMaterial = shader.material as ShaderMaterial
	material.set_shader_parameter('ascii_size', Vector2(ascii_x, ascii_y))
	
	#Add 3d scene to the viewport/3d cutscene block
	viewport.add_child.call_deferred(current_instance)
	viewport.move_child.call_deferred(current_instance, 0)
	
	
func _process(delta):
	var texture = viewport.get_texture()
	sprite.texture = texture

func leave(title := ""): 
	#current_instance.queue_free()
	viewport.set_update_mode(viewport.UPDATE_DISABLED)
	current_instance.queue_free()
	if (title != ""):
		StoryManager.continue_story(title)
	else:
		StoryManager.continue_story()
	
func _input(event):
	$Viewport._input(event)
