class_name Character extends CharacterBody2D


@export var speed: float = 40.0

@export var display_name: String


var zombie_textures: Array[CompressedTexture2D] = [
	preload("res://assets/sprites/zombies/zombie1.png"),
	preload("res://assets/sprites/zombies/zombie2.png"),
	preload("res://assets/sprites/zombies/zombie3.png"),
	preload("res://assets/sprites/zombies/zombie4.png")
]


func _enter_tree() -> void:
	var sprites: Array[Node] = $AnimatedCharacter/Sprites.get_children()
	var texture: CompressedTexture2D = zombie_textures.pick_random()
	
	for sprite in sprites:
		sprite.texture = texture
