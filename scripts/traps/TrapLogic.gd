extends Node2D

@export var camera : CharacterBody2D

var traps : Array[Trap] = [Trap.new()]
var curr_trap : Trap

func _ready():
	for trap in get_children():
		traps.append(trap)

func _process(delta):
	for trap in get_children():
		update_pos(trap)
		place_trap(trap)

func update_pos(trap : Node2D):
	curr_trap = traps[traps.find(trap) - 1]
	if (curr_trap.position != trap.position):
		curr_trap.position = trap.position

func trap_off_frame(trap : Node2D):
	var trap_to_screen = int(trap.position.x + camera.position.x) % 320
	return (trap_to_screen + 1 == get_viewport_rect().size.x)

func place_trap(trap : Node2D):
	if (trap_off_frame(trap)):
		trap.position.x = camera.position.x + get_viewport_rect().size.x/2
