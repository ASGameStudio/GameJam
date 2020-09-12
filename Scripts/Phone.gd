extends Control

enum Screen {WALLPAPER, CONTACTS, BOSS, CLINIC}
var Current_Screen: int = 0

var Victory = false
var Boss_Read = false
var Clinic_Read_1 = false
var Clinic_Read_2 = false

onready var Wall_Paper: TextureRect = $Frame/Wall_Paper
onready var Contacts: TextureRect = $Frame/Contacts
onready var Message: TextureRect = $Frame/Messages

onready var Contacts_Content: VBoxContainer = $Frame/Contacts/Contacts
onready var Messages_Content: VBoxContainer = $Frame/Messages/TextMessages

onready var Notification_Dot: TextureRect = $Frame/Wall_Paper/TextMessage/TextureRect
onready var Notification_Label: Label = $Frame/Wall_Paper/TextMessage/TextureRect/Label

onready var Messages_Label: Label = $Frame/Messages/Label

onready var Boss_Msg: TextureRect = $Frame/Messages/TextMessages/Boss
onready var Clinic_Msg_1: TextureRect = $Frame/Messages/TextMessages/Clinic1
onready var Clinic_Msg_2: TextureRect = $Frame/Messages/TextMessages/Clinic2

func _ready():
	update_display()

func update_display() -> void:
	update_dot()
	Wall_Paper.visible = false
	Contacts.visible = false
	Message.visible = false
	Contacts_Content.visible = false
	Messages_Content.visible = false
	Boss_Msg.visible = false
	Clinic_Msg_1.visible = false
	Clinic_Msg_2.visible = false
	match Current_Screen:
		Screen.WALLPAPER:
			Wall_Paper.visible = true
		Screen.CONTACTS:
			Contacts.visible = true
			Contacts_Content.visible = true
		Screen.BOSS:
			Messages_Label.set_text("The Boss")
			Message.visible = true
			Messages_Content.visible = true
			Boss_Msg.visible = true
			Boss_Read = true
		Screen.CLINIC:
			Messages_Label.set_text("Free Clinic")
			Message.visible = true
			Messages_Content.visible = true
			Clinic_Msg_1.visible = true
			Clinic_Read_1 = true
			if Victory:
				Clinic_Msg_2.visible = true
				Clinic_Read_2 = true

func update_dot() -> void:
	Notification_Dot.visible = false
	var temp = 0
	if !Boss_Read: temp += 1
	if !Clinic_Read_1: temp += 1
	if !Clinic_Read_2 && Victory: temp += 1
	if temp > 0:
		Notification_Dot.visible = true
		Notification_Label.set_text(str(temp))

func _on_TextureButton_pressed():
	Current_Screen = Screen.CONTACTS
	update_display()

func _on_BackArrow_pressed():
	match Current_Screen:
		Screen.BOSS:
			Current_Screen = Screen.CONTACTS
		Screen.CLINIC:
			Current_Screen = Screen.CONTACTS
		Screen.CONTACTS:
			Current_Screen = Screen.WALLPAPER
	update_display()

func _on_Boss_pressed():
	Current_Screen = Screen.BOSS
	update_display()

func _on_Clinic_pressed():
	Current_Screen = Screen.CLINIC
	update_display()


func _on_Button_pressed():
	Victory = true
