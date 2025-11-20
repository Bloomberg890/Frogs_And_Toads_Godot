extends Area2D

const CELL_WIDTH := 96   # 1152 / 12
var direction := Vector2.RIGHT   # move right
@onready var anim = $AnimatedSprite2D

func _ready():
	# Start at tile (3, 6)
	position = Vector2(2 * CELL_WIDTH - 34, 5 * CELL_WIDTH)
	print("Frog start position:", position)
	anim.play("front_rest")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		move_one_cell()

func move_one_cell():
	anim.play("side_jump")

	var start_pos = position
	var end_pos = start_pos + direction * Vector2(CELL_WIDTH, 0)

	var jump_height = -40
	var duration = 0.6   # ⬅ Longer jump time

	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(self, "position:x", end_pos.x, duration)
	tween.parallel().tween_property(self, "position:y", start_pos.y + jump_height, duration / 2)
	tween.parallel().tween_property(self, "position:y", end_pos.y, duration / 2).set_delay(duration / 2)

	await tween.finished
	anim.play("side_rest")
