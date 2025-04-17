extends CharacterBody2D

class_name hrac

# rychlostp ohybu doleva/doprava
var rychlost = 150
var gravitace = 10
var silaSkoku = 400
var skore = 0
var stopnuto = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("skok") and is_on_floor():
		velocity.y = - silaSkoku
		$AnimatedSprite2D.play("skok")
	elif not is_on_floor():
		velocity.y += gravitace
		$AnimatedSprite2D.play("pad")

	var smer = Input.get_axis("vlevo", "vpravo")
	if smer:
		velocity.x = smer*rychlost
		if is_on_floor():
			$AnimatedSprite2D.play("beh")
		$AnimatedSprite2D.flip_h = (smer<0)
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite2D.play("stoj")
 
	if not stopnuto:
		move_and_slide()

func pridejSkore(kolik: int) -> void:
	skore += kolik
	print("Skore +" + str(kolik) + "=>" + str(skore))
	
	($"../Platno/LabelSkore" as Label).text = str(skore)

func stop():
	stopnuto = true

func start():
	stopnuto = false

func restart():
	rychlost = 150
	gravitace = 10
	silaSkoku = 400
	skore = 0
	pridejSkore(0) # promaze ukazatel skore
	stopnuto = false
	position.x = 400
	position.y = 288
	move_and_slide()
