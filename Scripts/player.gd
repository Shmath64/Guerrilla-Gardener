extends CharacterBody2D
#hello
@export var speed : int
@export var camera_smooth_speed : int = 5 #px/s
var direction_facing
var move_input = Vector2.ZERO
var bullet = preload("res://Scenes/bullet.tscn")
var current_accuracy = 10
var muzzle_speed = 1600
var muzzle_global_position : Vector2
var gun_on_left_side : bool
var max_ammo = 20
var ammo_left : int
var fire_time = 0.1 #Seconds
var fire_time_left : float = 0 #Time until the next round can be fired

func _ready():
	$Camera2D.position_smoothing_speed = camera_smooth_speed
	ammo_left = max_ammo

func point_gun(): 
	direction_facing = get_angle_to(get_global_mouse_position())
	$Gun.rotation = direction_facing
	gun_on_left_side = abs(direction_facing) > PI/2
	$Gun/GunSprite.flip_v  = gun_on_left_side
	$PlayerSprite.flip_h = !gun_on_left_side
	
func get_movement_input():
	move_input.x = Input.get_axis("ui_left", "ui_right")
	move_input.y = Input.get_axis("ui_up", "ui_down")
	
func fire():
	ammo_left -= 1
	fire_time_left = fire_time
	var new_bullet = bullet.instantiate()
	new_bullet.position = $Gun/GunSprite/MuzzleFlipped.global_position if gun_on_left_side else $Gun/GunSprite/Muzzle.global_position
	if randi()%2: #flip a coin (to add or subtract angle for accuracy)
		new_bullet.rotation = direction_facing + randf() / current_accuracy #random integer divided by accuracy score
	else:
		new_bullet.rotation = direction_facing - randf() / current_accuracy
	new_bullet.speed = muzzle_speed
	get_parent().add_child(new_bullet)

func pull_trigger(): #What happens when trigger pulled (check if firing is possible)
	if ammo_left > 0 and fire_time_left <=0:
		fire()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire_time_left = max(fire_time_left-delta, 0)
	$Camera2D.position = get_local_mouse_position() / 4
	point_gun()
	get_movement_input()
	set_velocity(move_input*speed)
	move_and_slide()
	if Input.is_action_pressed("fire_primary"):
		pull_trigger()

