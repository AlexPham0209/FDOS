extends CharacterBody3D

@export var speed = 200
@export var sensitivity : float = 10
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var jump = 200
@onready var head = $Head


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	move(delta)
	move_and_slide()

func move(delta):
	#Calculate a 2d vector from the inputs
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	#Convert to a 3d vector with the x being the input vector x and the z being the input vector y.  Then normalized it
	var direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	#If set velocity to the direction multiplied by the speed
	if (direction):
		self.velocity.x = direction.x * speed * delta
		self.velocity.z = direction.z * speed * delta
	else:
		self.velocity.x = move_toward(velocity.x, 0, speed)
		self.velocity.z = move_toward(velocity.z, 0, speed)
	
	if (!is_on_floor()):
		self.velocity.y -= gravity * delta

func _unhandled_input(event):
	if (event is InputEventMouseMotion):
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
