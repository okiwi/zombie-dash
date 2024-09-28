extends Character


@export var delay: Array[float] = [2, 3]


var is_moving: bool = false


func _ready() -> void:
	%Timer.timeout.connect(_on_timeout)


func _physics_process(_delta: float) -> void:
	if not is_moving:
		$AnimatedSprite2D.play("idle")
		return
	
	$AnimatedSprite2D.play("walk")
	velocity = Vector2.RIGHT * speed
	move_and_slide()


func _on_timeout():
	randomize()
	%Timer.wait_time = randf_range(delay[0], delay[1])
	is_moving = !is_moving
