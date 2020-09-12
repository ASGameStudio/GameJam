extends KinematicBody2D

export(int) var Vital_Energy_Max: int = 100
var Vital_Energy = Vital_Energy_Max
var Vital_Energy_Drain = 10

func _ready():
	Event.connect("update_time", self, "Energy", [])
	Event.emit_signal("player_energy", Vital_Energy)
	pass


func Energy() -> void:
	Vital_Energy += -Vital_Energy_Drain
	Vital_Energy = clamp(Vital_Energy, 0, Vital_Energy_Max)
	Event.emit_signal("player_energy", Vital_Energy)
