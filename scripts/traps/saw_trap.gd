extends Trap

@export var animator : AnimationPlayer

func _ready():
	set_name("Saw Trap")
	animator.play("saw_trap")

func _process(delta):
	pass

