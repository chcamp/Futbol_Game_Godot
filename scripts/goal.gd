extends Area2D

signal goal_scored(team)

@export var team_name = "Team 1"  # "Team 1" o "Team 2"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("ball"):
		print("¡GOL para ", team_name, "!")
		goal_scored.emit(team_name)
		
		# Reiniciar posición del balón al centro
		await get_tree().create_timer(1.0).timeout
		reset_ball(body)

func reset_ball(ball):
	ball.global_position = Vector2(320, 240)  # Centro de la pantalla
	ball.velocity = Vector2.ZERO
