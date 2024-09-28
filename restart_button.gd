extends Button


func _ready() -> void:
	pressed.connect(_on_button_pressed)


func _on_button_pressed():
	get_tree().reload_current_scene()
