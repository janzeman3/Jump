extends Area2D

var hodnota = 10

func _on_body_entered(body: Node2D) -> void:
	if body is hrac:
		(body as hrac).pridejSkore(hodnota)
		queue_free()
		
		if $".." is hra:
			($".." as hra).melounMinus()
		#position.x +=30
		#queue_redraw()


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("default")
