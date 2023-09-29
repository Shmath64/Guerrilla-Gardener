extends CharacterBody2D
var DeathIndex = 2 #deprecated (Evan's code)
var max_health = 100
var speed = 200
var stunned = false

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	
	#position += (Player.position - position) / 50
	#look_at(Player.position)
	
	set_velocity(Vector2(speed, 0).rotated(get_angle_to(Player.position)))
	
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision:
		if collision.get_collider().has_method("touch_zombie"):
			collision.get_collider().call("touch_zombie") 
			stunned = true
			print("Stunned")
	
	
func hit(damage : float):
	max_health -= damage
	if max_health <= 0:
		die()
	$Sprite2D.modulate = Color(1,0,0)
	$FlashColorTimer.start()
	
		
"""
func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		DeathIndex -= 1
		
	if DeathIndex == 0:
		queue_free()
"""


func die():
	queue_free()

func _on_flash_color_timer_timeout():
	$Sprite2D.modulate = Color(1,1,1)
