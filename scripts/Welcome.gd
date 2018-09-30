extends PanelContainer

func on_start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")

func on_credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")

func on_settings_pressed():
	get_tree().change_scene("res://scenes/Settings.tscn")

func on_instructions_pressed():
	get_tree().change_scene("res://scenes/Instructions.tscn")
