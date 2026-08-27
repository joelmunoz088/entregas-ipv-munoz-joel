extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Esperar a que el MessageTimer termine de contar
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Hacer un temporizador rápido de 1 segundo en código
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
