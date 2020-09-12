extends KinematicBody2D

export(int) var Vital_Energy_Max: int = 100
var Vital_Energy = Vital_Energy_Max
var Vital_Energy_Drain = 10

func _ready():
	#Connect to a global signal of update time, which ticks every hour.
	#And we update out Energy Bar for the first time. -AS
	Event.connect("update_time", self, "Energy", [])
	Event.emit_signal("player_energy", Vital_Energy)
	pass

func _physics_process(delta):
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
