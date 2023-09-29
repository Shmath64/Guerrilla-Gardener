extends Node2D

var enemy = preload("res://Scenes/enemy.tscn")
var enemies_per_wave = [15, 25, 50, 80, 100]
var enemies_left_to_spawn : int = 0 #Will be set to enemies_per_wave[wave_num]
var wave_num = 0
var WORLD_LENGTH = 3000 #minimum distance from center to edge (stone)
var DISTANCE_FROM_GRASS = 200 #minimum distance from grass zombies can spawn
var RANGE = 6 # how spread out should the zombies be when spawning (as a multiplier for DISTANCE_FROM_GRASS)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_wave(wave_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Quadrants:
#   0
# 3   1
#   2
func spawn_wave(num : int):
	for i in range(enemies_per_wave[num]):
		var quadrant = randi_range(0,3)
		var pos = Vector2.ZERO
		match (quadrant):
			0: #At least world length away, plus something from DISTANCE_FROM_GRASS to DISTANCE_FROM_GRASS*RANGE
				pos = Vector2(randi_range(-WORLD_LENGTH, WORLD_LENGTH), -randi_range(DISTANCE_FROM_GRASS, RANGE*DISTANCE_FROM_GRASS) - WORLD_LENGTH)
			1: 
				pos = Vector2(randi_range(DISTANCE_FROM_GRASS, RANGE*DISTANCE_FROM_GRASS) + WORLD_LENGTH, randi_range(-WORLD_LENGTH, WORLD_LENGTH))
			2:
				pos = Vector2(-randi_range(DISTANCE_FROM_GRASS, RANGE*DISTANCE_FROM_GRASS) - WORLD_LENGTH, randi_range(-WORLD_LENGTH, WORLD_LENGTH))
			3: 
				pos = Vector2(randi_range(-WORLD_LENGTH, WORLD_LENGTH), randi_range(DISTANCE_FROM_GRASS, RANGE*DISTANCE_FROM_GRASS) + WORLD_LENGTH)
		spawn_enemy(pos)

func spawn_enemy(_position : Vector2):
	var new_enemy = enemy.instantiate()
	new_enemy.position = _position
	add_child(new_enemy)
	
	
	
	

