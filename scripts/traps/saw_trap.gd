extends Node2D

@export var animator : AnimationPlayer

func _ready():
	print("ready")
	animator.play("saw_trap")
	print(animator.is_playing())

