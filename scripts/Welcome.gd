extends PanelContainer

func on_start_pressed():
	get_tree().change_scene("res://scenes/main.tscn")

func on_credits_pressed():
	get_tree().change_scene("res://scenes/credits.tscn")
