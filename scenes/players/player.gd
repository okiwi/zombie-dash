extends Character


@export var number: int
@export var run_boost: float = 60
@export var crosshair_scene: PackedScene = preload("res://scenes/players/crosshair.tscn")
@export var crosshair_color: Color


var display_name: String

var speed_boost


func _ready() -> void:
	var crosshair = crosshair_scene.instantiate()
	crosshair.number = number
	crosshair.name = "Crosshair" + str(number)
	crosshair.position.y = randf_range(-100, 100)
	crosshair.color = crosshair_color
	get_parent().add_child(crosshair)


func _physics_process(_delta: float) -> void:
	var direction
	speed_boost = 0
	
	if Input.is_action_pressed("move" + str(number)):
		direction = Vector2.RIGHT
		$AnimatedSprite2D.play("walk")
	elif Input.is_action_pressed("run" + str(number)):
		direction = Vector2.RIGHT
		speed_boost = run_boost
		$AnimatedSprite2D.play("run")
	else:
		direction = Vector2.ZERO
		$AnimatedSprite2D.play("idle")
	
	velocity = direction * (speed + speed_boost)
	
	move_and_slide()
