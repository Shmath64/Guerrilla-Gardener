extends CharacterBody2D

@export var speed : int
var direction_facing
var move_input = Vector2.ZERO
var bullet = preload("res://Scenes/bullet.tscn")
var accuracy = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func point_gun():
	direction_facing = get_angle_to(get_global_mouse_position())
	$Gun.rotation = direction_facing
	
func get_movement_input():
	move_input.x = Input.get_axis("ui_right", "ui_left")
	move_input.y = Input.get_axis("ui_up", "ui_down")
	
func fire():
	var new_bullet = bullet.instantiate()
	new_bullet.position = $Gun.position
	if randi()%2: #flip a coin
		new_bullet.rotation = direction_facing + randf() / accuracy #add random int divided by accuracy to rotation
	else:
		new_bullet.rotation = direction_facing - randf() / accuracy
	new_bullet.speed = muzzle_speed
	get_parent().add_child(new_bullet)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	point_gun()
	get_movement_input()
	
