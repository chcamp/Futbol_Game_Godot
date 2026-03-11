extends CharacterBody2D

const FRICTION = 0.95
const MIN_VELOCITY = 10.0

func _ready():
	add_to_group("ball")

func _physics_process(delta):
	# Aplicar fricción
	velocity *= FRICTION
	
	# Detener si está muy lento
	if velocity.length() < MIN_VELOCITY:
		velocity = Vector2.ZERO
	
	# Mover el balón
	move_and_slide()

func kick(kick_velocity: Vector2):
	velocity = kick_velocity
