extends Area2D
var speed = 750

func rotate_me(rad: float):
	rotate(rad)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * delta


func _on_bullet_body_entered(body):
	# if body.is_in_group("enemies"):       
	body.queue_free()
	queue_free()
