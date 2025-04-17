extends Area2D

class_name pila

signal zasah_pilou

var nastartovano = false
var bezi = false

func _on_body_entered(body: Node2D) -> void:
	if body is hrac and nastartovano:
		print("Zasah" + str($CollisionShape2D.disabled))
		emit_signal("zasah_pilou")
		

func restart():
	visible = false
	nastartovano = false
	bezi = false
	$AnimatedSprite2D.play("vstup")
	$CollisionShape2D.set_deferred("disabled", "true")


func start():
	if not nastartovano:
		nastartovano = true
		visible = true
		$Timer.start()
		print("Start")

func stop():
	$CollisionShape2D.set_deferred("disabled", "true")
	nastartovano = false
	bezi = false
	$AnimatedSprite2D.play("off")

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play("off")
	$Timer2.start()


func _on_timer_2_timeout() -> void:
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play("on")
	bezi = true
