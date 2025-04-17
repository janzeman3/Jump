extends Node2D

class_name hra

@export var meloun: PackedScene

var pocetMelounu = 0
var maxMelounu = 10

func _on_timer_timeout() -> void:
	if pocetMelounu < maxMelounu:
		var m = meloun.instantiate()
		var vyska = randi()%8
		(m as Area2D).position.x =  48 + randi()%23 * 32 
		(m as Area2D).position.y = 152 + vyska * 64
		m.hodnota = (8-vyska) * 5
		print("Novy meloun: " + str(m.hodnota))
		add_child(m)
		pocetMelounu += 1

	var sec = int($TimerCas.time_left)
	var minuty = int(sec / 60)
	sec = sec % 60
	$Platno/LabelCas.text = "%02d:%02d" % [minuty,sec]
	
	if minuty <= 1 and not $Path2D/PathFollow2D/pila.nastartovano:
		$Path2D/PathFollow2D/pila.start()
		$Path2D2/PathFollow2D/pila.start()
	if minuty <= 0 and not $Path2D3/PathFollow2D/pila.nastartovano:
		$Path2D3/PathFollow2D/pila.start()

func melounMinus():
	pocetMelounu -= 1

func gameOver():
	print("GOver")
	$Timer.stop()
	$TimerCas.stop()
	$CharacterBody2D.stop()

	$Path2D/PathFollow2D/pila.stop()
	$Path2D2/PathFollow2D/pila.stop()
	$Path2D3/PathFollow2D/pila.stop()

	$OverPanel.visible = true
	$OverPanel/Label.text = "Score:" + str($CharacterBody2D.skore)


func _on_ready() -> void:
	$TimerCas.start()

func _on_timer_cas_timeout() -> void:
	gameOver()

func _process(delta: float) -> void:
	if $Path2D/PathFollow2D/pila.bezi:
		$Path2D/PathFollow2D.progress +=120*delta
	if $Path2D2/PathFollow2D/pila.bezi:
		$Path2D2/PathFollow2D.progress +=120*delta
	if $Path2D3/PathFollow2D/pila.bezi:
		$Path2D3/PathFollow2D.progress +=120*delta
	
	if Input.is_action_just_pressed("esc"):
		gameOver()

func _on_yes_button_pressed() -> void:
	print("Restart")
	$CharacterBody2D.restart()

	$Path2D/PathFollow2D/pila.restart()
	$Path2D2/PathFollow2D/pila.restart()
	$Path2D3/PathFollow2D/pila.restart()

	$Timer.start()
	$TimerCas.start()

	$OverPanel.visible = false

func _on_no_button_pressed() -> void:
	get_tree().quit()

func _on_pila_zasah_pilou() -> void:
	gameOver()
