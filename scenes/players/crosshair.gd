extends Area2D


@export var speed: float = 150.0
@export var number: int
@export var color: Color


var has_shot := false
var target: Node


func _ready() -> void: 
	body_entered.connect(_on_body_entered)
	
	$Sprite2D.modulate = color


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
		
		if not target:
			return
		
		target.set_physics_process(false)
		target.find_child("AnimatedCharacter").find_child("AnimationPlayer").play("death")
		
		if not target.is_in_group("players"):
			return
		
		var target_crosshair = get_node("../Crosshair" + str(target.number))
		target_crosshair.visible = false
		target_crosshair.has_shot = true
		


func _on_body_entered(body):
	target = body
