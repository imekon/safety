extends PanelContainer

onready var label = $Panel/RichTextLabel

func _ready():
	var version = Engine.get_version_info()
	label.add_text("Made with Godot version " + version["string"])

func on_back_pressed():
	get_tree().change_scene("res://scenes/Welcome.tscn")

func on_text_meta_clicked(meta):
	OS.shell_open(meta)
