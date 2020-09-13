extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 250
const FRICTION = 500

var velocity = Vector2.ZERO

export(int) var Vital_Energy_Max: int = 100
var Vital_Energy = Vital_Energy_Max
var Vital_Energy_Drain = 10

func _ready():
	#Connect to a global signal of update time, which ticks every hour.
	#And we update out Energy Bar for the first time. -AS
	# warning-ignore:return_value_discarded
	Event.connect("update_time", self, "Energy", [])
	Event.emit_signal("player_energy", Vital_Energy)
	pass

#Uses our input map and our constats and variables at the top
#Creates movement for our player node
#Make sure to check your input mapping -JS
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_collide(velocity * delta)
	#Points the sprite to the Mouse on every Physics Frame.
	#We should cache the $Sprite in a node, or we could just rotate the entire player instead of their sprite. -AS
	$Sprite.rotation = get_global_mouse_position().angle()

#Currently, this function is used for Energy Drain.
#As of now, Every hour tick will drain 10 Energy.
#We also use the Clamp Function to keep out energy within 0 to max.
#Emits a Signal for the UI to update. -AS
func Energy() -> void:
	Vital_Energy += -Vital_Energy_Drain
	Vital_Energy = clamp(Vital_Energy, 0, Vital_Energy_Max)
	Event.emit_signal("player_energy", Vital_Energy)
