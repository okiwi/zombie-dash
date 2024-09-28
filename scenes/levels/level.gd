extends Node2D


@export var zombies_num: int = 2
@export var zombie_scene: PackedScene
@export var players: Array[PackedScene]


var characters: Array[Character]


func _ready() -> void:
	for i in zombies_num:
		characters.append(zombie_scene.instantiate())
