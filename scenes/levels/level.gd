extends Node2D


@export var zombies_num: int = 2
@export var players: int = 2
@export var zombie_scene: PackedScene
@export var player_scene: PackedScene
@export var spawn_points: Node


var characters: Array[Character]


@onready var finish_line: Area2D = $Finish


func _ready() -> void:
	($/root/Main/GUI as Control).visible = false
	finish_line.body_entered.connect(_on_character_finished)
	
	spawn_characters()


func spawn_characters() -> void:
	for i in zombies_num:
		var zombie = zombie_scene.instantiate()
		zombie.name = "Zombie " + str(i + 1)
		characters.append(zombie)
	for i in players:
		var player = player_scene.instantiate()
		player.number = i + 1
		player.name = "Player" + str(i + 1)
		characters.append(player)
	
	characters.shuffle()
	
	var points := spawn_points.get_children()
	for i in points.size():
		characters[i].position = points[i].position
		add_child(characters[i])


func _on_character_finished(body) -> void:
	($/root/Main/GUI as Control).visible = true
	($/root/Main/GUI/Label as Label).text = body.name + " wins!"
	$/root/Main/Music.playing = false
	$/root/Main/Victory.play()
	
