extends CharacterBody2D

const SPEED = 150.0
const KICK_POWER = 400.0
const KICK_RANGE = 30.0

var can_kick = true

func _physics_process(delta):
	# Obtener input del jugador
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	# Normalizar dirección para movimiento diagonal consistente
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Aplicar velocidad
	velocity = direction * SPEED
	
	# Mover el jugador
	move_and_slide()
	
	# Sistema de pateo
	if Input.is_action_just_pressed("kick") and can_kick:
		try_kick()

func try_kick():
	# Buscar el balón cerca
	var ball = get_tree().get_first_node_in_group("ball")
	if ball:
		var distance = global_position.distance_to(ball.global_position)
		if distance < KICK_RANGE:
			# Calcular dirección del pateo
			var kick_direction = (ball.global_position - global_position).normalized()
			
			# Patear el balón
			if ball.has_method("kick"):
				ball.kick(kick_direction * KICK_POWER)
			
			can_kick = false
			await get_tree().create_timer(0.3).timeout
			can_kick = true
