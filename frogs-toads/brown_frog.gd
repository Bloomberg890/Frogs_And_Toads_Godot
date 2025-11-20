extends Area2D

var screen_size
func _ready():
	screen_size = get_viewport_rect().size

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
