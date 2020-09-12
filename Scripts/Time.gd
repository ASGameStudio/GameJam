extends Node2D

var pause: bool = false
var time: float
var add_time: float

var speed: float = 10
var mod_speed: float = 25

var seconds: int
var minutes: int
var hours: int

var last_minute: int
var last_hour: int

var speed_till
var speeding: bool
var speed_count: int

func _physics_process(delta):
	if !pause: time += delta * speed * mod_speed
	UpdateTime()

func UpdateTime():
	if add_time > 0:
		time += add_time
		add_time = 0
	var current_time = int(floor(time))
	seconds = current_time % 60
	minutes = (current_time / 60) % 60
	hours = (current_time / (60 * 60)) % 24
	if (hours != last_hour):
		last_hour = hours
		Event.emit_signal("update_time")

func CostTime():
	add_time = 1800



func GetTimeString() -> String:
	return "%02d:%02d" % [hours, minutes]

