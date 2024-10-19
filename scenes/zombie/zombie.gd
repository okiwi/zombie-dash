extends Character


@export var min_delay: float = 0.4
@export var max_delay: float = 1


@export var is_moving: bool = false


func _ready() -> void:
	%Timer.timeout.connect(_on_timeout)


func _physics_process(_delta: float) -> void:
	if not is_moving:
		$AnimatedCharacter/AnimationPlayer.play("idle")
		return
	
	$AnimatedCharacter/AnimationPlayer.play("walk")
	velocity = Vector2.RIGHT * speed
	move_and_slide()


func _on_timeout():
	randomize()
	%Timer.wait_time = randf_range(min_delay, max_delay)
	is_moving = !is_moving
