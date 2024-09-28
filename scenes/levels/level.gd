extends Node2D


@export var zombies_num: int = 2
@export var zombie_scene: PackedScene
@export var players: Array[PackedScene]
@export var spawn_points: Node


var characters: Array[Character]


@onready var finish_line: Area2D = $Finish


func _ready() -> void:
	finish_line.body_entered.connect(_on_character_finished)
	
	spawn_characters()


func spawn_characters() -> void:
	for i in zombies_num:
		characters.append(zombie_scene.instantiate())
	for player in players:
		characters.append(player.instantiate())
	
	characters.shuffle()
	
	var points := spawn_points.get_children()
	for i in points.size():
		characters[i].position = points[i].position
		add_child(characters[i])


func _on_character_finished(body) -> void:
	print(body.name)
