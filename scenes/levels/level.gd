extends Node2D


@export var num_characters: int = 2
@export var num_players: int = 2
@export var zombie_scene: PackedScene
@export var player_scene: PackedScene
@export var character_height: int = 34
@export var colors: Array[Color]
@export var spawn_offset: Vector2 = Vector2(50, 10)

@export var base_height: int = 360

var characters: Array[Character]

@onready var num_zombies: int = num_characters - num_players


@onready var finish_line: Area2D = $Finish


func _ready() -> void:
	($/root/Main/GUI as Control).visible = false
	finish_line.body_entered.connect(_on_character_finished)
	
	spawn_characters()


func spawn_characters() -> void:
	for i in num_zombies:
		var zombie = zombie_scene.instantiate()
		zombie.name = "Zombie " + str(i + 1)
		characters.append(zombie)
	for i in num_players:
		var player = player_scene.instantiate()
		player.number = i
		player.name = "Player" + str(i)
		var player_color = colors.pick_random()
		colors.remove_at(colors.find(player_color))
		player.crosshair_color = player_color
		player.display_name = "Player " + NumberToWords.to_words(i + 1).capitalize()
		characters.append(player)
	
	characters.shuffle()
	
	var total_characters: int = num_zombies + num_players
	for i in num_zombies + num_players:
		var available_height = base_height - spawn_offset.y
		var spacing = available_height / total_characters + 1
		var y_position = spawn_offset.y + i * spacing
		
		characters[i].position = Vector2(spawn_offset.x, y_position)
		add_child(characters[i])


func _on_character_finished(body) -> void:
	($/root/Main/GUI as Control).visible = true
	($/root/Main/GUI/Label as Label).text = body.display_name + " wins!"
	get_tree().paused = true
	$/root/Main/Music.playing = false
	$/root/Main/Victory.play()
	
