extends CharacterBody2D

var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	set_velocity(Vector2(speed,0).rotated(rotation))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(velocity*delta)
