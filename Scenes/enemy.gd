extends PhysicsBody2D
var velocity = Vector2()
var DeathIndex = 2
func _physics_process(_delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position) / 50
	look_at(Player.position)
	
	move_and_collide(velocity)
func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		DeathIndex -= 1
		
	if DeathIndex == 0:
		queue_free()
