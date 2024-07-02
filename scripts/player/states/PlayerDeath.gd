extends State
class_name PlayerDeath

@export var player : CharacterBody2D
@export var death_anim : bool
@export var animator : AnimationPlayer

func Enter():
	print("Dead")
	animator.play("death")

func Update(_delta: float):
	if death_anim:
		if player:
			player.queue_free()

