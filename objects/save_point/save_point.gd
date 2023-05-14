extends Area2D


func body_entered(body):
	if body is CharacterBody2D:
		Global.respawn = position
	
