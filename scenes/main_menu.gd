extends Control


@export var num_zombies: int = 10
@export var zombie_scene: PackedScene

@export var level_scene: PackedScene


func _ready() -> void:
	%Edge.body_entered.connect(_on_body_entered)
	%PlayButton.pressed.connect(_on_play_pressed)
	%QuitButton.pressed.connect(_on_quit_pressed)
	
	for i in num_zombies:
		var zombie: CharacterBody2D = zombie_scene.instantiate()
		zombie.position = %Spawn.position
		zombie.find_child("Timer").queue_free()
		zombie.is_moving = true
		add_child(zombie)
		
		await %Spawn/Timer.timeout


func _on_body_entered(body) -> void:
	body.position = $Spawn.position


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
	
