extends PanelContainer

enum { MALE, FEMALE, OTHER, UNKNOWN }

var pronouns_group
var sexuality_group

var pronoun = OTHER
var preference = UNKNOWN

onready var malePronoun = $Panel/MaleCheck
onready var femalePronoun = $Panel/FemaleCheck
onready var otherPronoun = $Panel/OtherCheck

onready var malePreference = $Panel/MalePreference
onready var femalePreference = $Panel/FemalePreference
onready var anyPreference = $Panel/AnyPreference
onready var noPreference = $Panel/NoPreference

func _ready():
	pronouns_group = ButtonGroup.new()
	malePronoun.set_button_group(pronouns_group)
	femalePronoun.set_button_group(pronouns_group)
	otherPronoun.set_button_group(pronouns_group)
	
	sexuality_group = ButtonGroup.new()
	malePreference.set_button_group(sexuality_group)
	femalePreference.set_button_group(sexuality_group)
	anyPreference.set_button_group(sexuality_group)
	noPreference.set_button_group(sexuality_group)

func on_back_pressed():
	get_tree().change_scene("res://scenes/Welcome.tscn")

func on_male_preference_toggled(button_pressed):
	if button_pressed:
		preference = MALE

func on_female_preference_toggled(button_pressed):
	if button_pressed:
		preference = FEMALE

func on_any_preference_toggled(button_pressed):
	if button_pressed:
		preference = OTHER

func on_no_preference_toggled(button_pressed):
	if button_pressed:
		preference = UNKNOWN

func on_male_pronoun_toggled(button_pressed):
	if button_pressed:
		pronoun = MALE

func on_female_pronoun_toggled(button_pressed):
	if button_pressed:
		pronoun = FEMALE

func on_other_pronoun_toggled(button_pressed):
	if button_pressed:
		pronoun = OTHER

func on_save_pressed():
	pass # replace with function body

func on_religious_toggled(button_pressed):
	pass # replace with function body
