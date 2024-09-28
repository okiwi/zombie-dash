class_name Character extends CharacterBody2D


@export var speed: float = 40.0
@export var sprite_frames: Array[SpriteFrames]


func _enter_tree() -> void:
	$AnimatedSprite2D.sprite_frames = sprite_frames.pick_random()
