extends TextureProgress

func _ready():
	Event.connect("player_energy", self, "update_energy", [])

func update_energy(_value) -> void:
	value = _value
