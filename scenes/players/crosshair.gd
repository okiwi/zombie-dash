extends Area2D


@export var speed: float = 150.0
@export var input_prefix: String


var has_shot := false
var target: Node


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		input_prefix + "_crosshair_left", input_prefix + "_crosshair_right",
		input_prefix + "_crosshair_up", input_prefix + "_crosshair_down",
	)
	
	var velocity = direction.normalized() * speed * delta
	position += velocity


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(input_prefix + "_shoot") and not has_shot:
		$AudioStreamPlayer2D.play()
		has_shot = true
		
		if not target:
			return
		
		if target.name == "PlayerOne":
			$"../CrosshairOne".queue_free()
		if target.name == "PlayerTwo":
			$"../CrosshairTwo".queue_free()
			
		target.set_physics_process(false)
		target.find_child("AnimatedSprite2D").play("death")
			


func _on_body_entered(body):
	target = body
