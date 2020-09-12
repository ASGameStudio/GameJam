extends Control

onready var Time_Label: Label = $Vital_Texture/Time_Label
onready var HP_Bar: TextureProgress = $Vital_Texture/HP
onready var Energy_Bar: TextureProgress = $Vital_Texture/Energy

#Basically, this script listens for global signals then fires a function to update any UI
#related elements. -AS
func _ready():
	Event.connect("player_health", self, "update_health", [])
	Event.connect("player_energy", self, "update_energy", [])

#Though we do update the Clock UI element on update frames. -AS
func _process(delta):
	Time_Label.set_text(str(Time.GetTimeString()))

func update_health(_value) -> void:
	HP_Bar.value = _value

func update_energy(_value) -> void:
	Energy_Bar.value = _value
