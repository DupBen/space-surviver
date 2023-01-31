extends Node2D

@export var spawnsArr: Array[Spawn_info] = []

var player

var time = 0


func _ready() -> void:
	if Globals.Player:
		player = Globals.Player


func _on_timer_timeout() -> void:
	print("Spawner timeout")
	if not player:
		return
		
	time += 1
	var spawns = spawnsArr
	for spawn in spawns:
		if time <= spawn.time_start and time >= spawn.time_end:
			return
		
		if spawn.spawn_delay_counter < spawn.spawn_delay:
			spawn.spawn_delay_counter += 1
			return
			
		spawn.spawn_delay_counter = 0
		var enemy = load(str(spawn.spawn.resource_path))
		var counter = 0
		# Spawn X based on spawn amount config
		while counter < spawn.spawn_amount:
			var enemy_spawn = enemy.instantiate()
			var random_pos = get_random_position()
			print("random pos", random_pos)
			enemy_spawn.global_position = random_pos
			add_child(enemy_spawn)
			counter += 1


func get_random_position():
	var viewport = get_viewport_rect().size * randf_range(1.1, 1.4)
	print("viewport", get_viewport_rect().size)
	
	var top_left = Vector2(player.global_position.x - viewport.x / 2, player.global_position.y - viewport.y / 2)
	var top_right = Vector2(player.global_position.x + viewport.x / 2, player.global_position.y - viewport.y / 2)
	var bottom_left = Vector2(player.global_position.x - viewport.x / 2, player.global_position.y + viewport.y / 2)
	var bottom_right = Vector2(player.global_position.x + viewport.x / 2, player.global_position.y + viewport.y / 2)
	
	var spawn_location = ["up", "down", "right", "left"].pick_random()
	
	var spawn_pos_min = Vector2.ZERO
	var spawn_pos_max = Vector2.ZERO
	
	match spawn_location:
		"up":
			spawn_pos_min = top_left
			spawn_pos_max = top_right
		"down":
			spawn_pos_min = bottom_left
			spawn_pos_max = bottom_right
		"left":
			spawn_pos_min = top_left
			spawn_pos_max = bottom_left
		"right":
			spawn_pos_min = top_right
			spawn_pos_max = bottom_right
	
	return Vector2(
		randf_range(spawn_pos_min.x, spawn_pos_max.x),
		randf_range(spawn_pos_min.x, spawn_pos_max.x)
	)
