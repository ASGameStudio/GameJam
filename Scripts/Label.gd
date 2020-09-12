extends Label

func _ready():
	Event.connect("update_time", self, "test", [])

func _process(delta):
	set_text(str(Time.GetTimeString()))

func test():
	print("Tick")
