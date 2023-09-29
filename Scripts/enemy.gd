extends PhysicsBody2D
var velocity = Vector2()
var DeathIndex = 2 #deprecated (Evan's code)
var max_health = 100

func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position) / 50
	look_at(Player.position)
	
	move_and_collide(velocity)
	
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
