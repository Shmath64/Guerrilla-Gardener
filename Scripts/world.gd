extends Node2D

var enemy = preload("res://Scenes/enemy.tscn")
var size_of_world = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		spawn_enemy(Vector2(randi_range(-size_of_world, size_of_world), randi_range(-size_of_world, size_of_world)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_enemy(_position : Vector2):
	var new_enemy = enemy.instantiate()
	new_enemy.position = _position
	add_child(new_enemy)
	
	
	
	

