extends Node

const CHECK_TOLERANCE = 1.0 

# Function now correctly accepts TWO arguments: target_pos and moving_frog
func is_position_occupied(target_pos: Vector2, moving_frog: Node) -> bool:
	var all_frogs = get_tree().get_nodes_in_group("frogs")
	
	for frog in all_frogs:
		# 1. Skip the frog that is currently checking (the one passed in as 'moving_frog')
		if frog == moving_frog:
			continue
			
		# 2. Check the position distance
		if frog.global_position.distance_to(target_pos) < CHECK_TOLERANCE:
			return true # Found a different frog blocking the way
			
	return false
