extends Character


@export var number: int
@export var run_boost: float = 60
@export var crosshair_scene: PackedScene = preload("res://scenes/players/crosshair.tscn")
@export var crosshair_color: Color


var speed_boost


func _ready() -> void:
	var crosshair = crosshair_scene.instantiate()
	crosshair.number = number
	crosshair.name = "Crosshair" + str(number)
	crosshair.color = crosshair_color

	
	var half_screen_height = get_viewport_rect().size.y / 2
	crosshair.position.x = get_viewport_rect().size.x / 2
	crosshair.position.y = randf_range(half_screen_height - 200, half_screen_height + 200)

	get_parent().add_child(crosshair)


func _physics_process(_delta: float) -> void:
	var direction
	speed_boost = 0
	
	if Input.is_action_pressed("move" + str(number)):
		direction = Vector2.RIGHT
		$AnimatedCharacter/AnimationPlayer.play("walk")
	elif Input.is_action_pressed("run" + str(number)):
		direction = Vector2.RIGHT
		speed_boost = run_boost
		$AnimatedCharacter/AnimationPlayer.play("run")
	else:
		direction = Vector2.ZERO
		$AnimatedCharacter/AnimationPlayer.play("idle")
	
	velocity = direction * (speed + speed_boost)
	
	move_and_slide()
