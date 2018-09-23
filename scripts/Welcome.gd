extends PanelContainer

onready var text = $Panel/RichTextLabel

var messages = [ "How do you define a safe space?\n\n",
				"A place where you can be yourself\n",
				"A place where you can love who you love\n",
				"A place where you can dress as you like\n",
				"A place where nobody will attack you for being you\n\n",
				"This a game that looks at 'Safe Space'\n",
				"and the things that can reinforce or break it" ]

func _ready():
	for message in messages:
		text.add_text(message)

func on_start_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
