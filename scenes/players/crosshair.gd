extends Area2D


@export var speed: float = 150.0
@export var number: int


var has_shot := false
var target: Node


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"crosshair_left" + str(number), "crosshair_right" + str(number),
		"crosshair_up" + str(number), "crosshair_down" + str(number),
	)
	
	var velocity = direction.normalized() * speed * delta
	position += velocity


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot" + str(number)) and not has_shot:
		$AudioStreamPlayer2D.play()
		has_shot = true
		$Bullet.visible = false
		
		if not target:
			return
		
		get_parent().find_child("Crosshair" + str(target.number)).visible = false
			
		target.set_physics_process(false)
		target.find_child("AnimatedSprite2D").play("death")
			


func _on_body_entered(body):
	target = body
