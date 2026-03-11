extends Node2D

var score_team1 = 0
var score_team2 = 0

@onready var score_label = $UI/ScoreLabel

func _ready():
	update_score_display()
	
	# Conectar señales de las porterías
	var goals = get_tree().get_nodes_in_group("goal")
	for goal in goals:
		goal.goal_scored.connect(_on_goal_scored)

func _on_goal_scored(team_name):
	if team_name == "Team 1":
		score_team1 += 1
	elif team_name == "Team 2":
		score_team2 += 1
	
	update_score_display()

func update_score_display():
	score_label.text = str(score_team1) + " - " + str(score_team2)
