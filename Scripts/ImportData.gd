extends Node

#This section links the json file with the events
#And is mounted to the world scene
#Remove print in final verion, as it is present to test -JS
var event_data

func _ready():
	var eventdata_file = File.new()
	eventdata_file.open("res://Data/Gamejam 1 - Sheet1.json", File.READ)
	var eventdata_json = JSON.parse(eventdata_file.get_as_text())
	eventdata_file.close()
	event_data = eventdata_json.result
	print(event_data)
