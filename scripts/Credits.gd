extends PanelContainer

onready var label = $Panel/RichTextLabel

var messages = [ "Safe Space\n\n",
				 "Copyright (c) 2018 Pete Goodwin\n\n",
				 "A game for the Rainbow Game Jame 2018\n\n",
				 "I came up with the idea of a 'safe space' a place",
				 " where you can hide from the outside world and be safe",
				 " where nothing can reach or hurt you\n\n" ]
					
func _ready():
	for message in messages:
		label.add_text(message)
	
	var version = Engine.get_version_info()
	label.add_text("Made with Godot version " + version["string"])

func on_back_pressed():
	get_tree().change_scene("res://scenes/Welcome.tscn")
