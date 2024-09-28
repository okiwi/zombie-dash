extends Character


@export var finish_line: Area2D
@export var input_prefix: String
@export var run_boost: float = 60


var speed_boost


func _ready() -> void:
	finish_line.body_entered.connect(_on_body_entered)


func _physics_process(_delta: float) -> void:
	var direction
	speed_boost = 0
	
	if Input.is_action_pressed(input_prefix + "_move"):
		direction = Vector2.RIGHT
		$AnimatedSprite2D.play("walk")
	elif Input.is_action_pressed(input_prefix + "_run"):
		direction = Vector2.RIGHT
		speed_boost = run_boost
		$AnimatedSprite2D.play("run")
	else:
		direction = Vector2.ZERO
		$AnimatedSprite2D.play("idle")
	
	velocity = direction * (speed + speed_boost)
	
	move_and_slide()


func _on_body_entered(_body):
	position = Vector2(-450, 0)
