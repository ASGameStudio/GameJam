extends KinematicBody2D

export(float) var max_speed: float = 250
var inputDir: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var use_acceleration: bool = true
const acceleration: float = 30.0
const friction: float = 60.0

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
	#Moved Player Movement to it's own Function. -AS
	Move()
	
	#Points the sprite to the Mouse on every Physics Frame.
	#We should cache the $Sprite in a node, or we could just rotate the entire player instead of their sprite. -AS
#	Commented out cause it doesn't look good with player.
#	$Sprite.rotation = get_global_mouse_position().angle()


#Moved movement back to function for ease of editing. -AS
#Also drastically reduced friction/acceleration -AS
func Move() -> void:
	inputDir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputDir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if use_acceleration:
		if inputDir != Vector2.ZERO:
				velocity += inputDir * acceleration
				velocity = velocity.clamped(max_speed)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction)
	else:
		velocity * max_speed
	var _Move = move_and_slide(velocity)

#Currently, this function is used for Energy Drain.
#As of now, Every hour tick will drain 10 Energy.
#We also use the Clamp Function to keep out energy within 0 to max.
#Emits a Signal for the UI to update. -AS
func Energy() -> void:
	Vital_Energy += -Vital_Energy_Drain
	Vital_Energy = clamp(Vital_Energy, 0, Vital_Energy_Max)
	Event.emit_signal("player_energy", Vital_Energy)
