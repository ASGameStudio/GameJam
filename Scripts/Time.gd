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
	#Every physics frame we add time and any speed mods to the time variable. -AS
	if !pause: time += delta * speed * mod_speed
	UpdateTime()

#This does the calculation for time.
#First we add any extra time if we used a Time.CostTime Function
#We then round our time down, and cast it as an integer.
#Then we use math to figure out seconds, minutes, hours.
#Lastly if we're on a new hour we do a global signal for it. -AS
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


#Currently a helper function that can be called from other scripts via Time.CostTime
#We should make it accept an argument so we can call it Time.CostTime(1800) - AS
func CostTime():
	#1800 seems to be 30 minutes. -AS
	add_time = 1800


#Returns a string for the UI to function. "12:34"
#We should add AM and PM to it eventually, or just use Army Time for Fun. -AS
func GetTimeString() -> String:
	return "%02d:%02d" % [hours, minutes]

