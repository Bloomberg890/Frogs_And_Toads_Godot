extends Area2D

@onready var anim = $AnimatedSprite2D

@export var start_index: int = 0

var current_index = -1
var main
var is_jumping = false


func setup(main_ref):
	main = main_ref

	anim.play("side_rest")

	current_index = start_index
	global_position = main.points[current_index]
	main.occupied[current_index] = true


func _input_event(_viewport, event, _shape_idx):
	if main == null:
		return
	if main.state != main.GameState.PLAYING:
		return

	if event.is_pressed():
		move_to_next()


func move_to_next():
	if is_jumping:
		return

	var step1 = current_index + 1
	var step2 = current_index + 2
	var target = -1

	# case 1: next point free → normal move
	if step1 < main.points.size() and not main.occupied[step1]:
		target = step1

	# case 2: next occupied, next-to-next free → jump
	elif step2 < main.points.size() and main.occupied[step1] and not main.occupied[step2]:
		target = step2

	else:
		return

	jump_to(target)

func can_move():
	if main == null:
		return false

	var step1 = current_index + 1
	var step2 = current_index + 2

	# step1 possible
	if step1 < main.points.size() and not main.occupied[step1]:
		return true

	# step2 possible
	if step2 < main.points.size() and main.occupied[step1] and not main.occupied[step2]:
		return true

	return false

func jump_to(target):
	is_jumping = true

	anim.play("side_jump")
	anim.sprite_frames.set_animation_loop("side_jump", true)

	var fps = anim.sprite_frames.get_animation_speed("side_jump")
	var frames = anim.sprite_frames.get_frame_count("side_jump")
	var total_time = (frames / fps) * 0.8  # keep your timing

	var start_pos = global_position
	var end_pos = main.points[target]
	var distance = abs(target - current_index)
	
	# update occupancy
	main.occupied[current_index] = false
	current_index = target
	main.occupied[current_index] = true


	var height = 40.0          # normal step
	if distance == 2:
		height = 90.0  
		total_time = (frames / fps) * 1 
	var t := 0.0

	while t < total_time:
		var progress = t / total_time

		var pos = start_pos.lerp(end_pos, progress)
		var arc = -4 * height * progress * (progress - 1)

		pos.y -= arc
		global_position = pos

		await get_tree().process_frame
		t += get_process_delta_time()

	global_position = end_pos

	anim.sprite_frames.set_animation_loop("side_jump", false)
	anim.play("side_rest")

	is_jumping = false
	main.check_win()
	main.check_lose()
