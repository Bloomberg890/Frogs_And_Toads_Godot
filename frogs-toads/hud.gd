extends CanvasLayer

signal play_pressed
signal restart_pressed
signal quit_pressed

func show_menu():
	$Menu.visible = true
	$GameUI.visible = false
	$WinScreen.visible = false
	$LoseScreen.visible = false


func show_game():
	$Menu.visible = false
	$GameUI.visible = true   # 👈 keep buttons visible
	$WinScreen.visible = false
	$LoseScreen.visible = false


func show_win():
	$GameUI.visible = true   # optional (keep restart visible)
	$WinScreen.visible = true


func show_lose():
	$GameUI.visible = true
	$LoseScreen.visible = true


# Button callbacks
func _on_play_button_pressed():
	emit_signal("play_pressed")

func _on_restart_button_pressed():
	emit_signal("restart_pressed")

func _on_quit_button_pressed():
	emit_signal("quit_pressed")
