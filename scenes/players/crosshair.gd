extends Area2D


@export var speed: float = 150.0
@export var input_prefix: String


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		input_prefix + "_crosshair_left", input_prefix + "_crosshair_right",
		input_prefix + "_crosshair_up", input_prefix + "_crosshair_down",
	)
	
	var velocity = direction.normalized() * speed * delta
	position += velocity
