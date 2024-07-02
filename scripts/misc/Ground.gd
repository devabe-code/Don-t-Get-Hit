extends Node2D

@export var player = CharacterBody2D

func _ready():
	pass

func _process(delta):
	position.x = player.position.x
