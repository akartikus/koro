extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var Bullet : PackedScene

var screen_size # Size of the game window.
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		direction = _calculate_direction(velocity)
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if Input.is_action_just_pressed("shoot"):
		shoot()	
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func shoot():
	var bullet: Area2D = Bullet.instantiate()
	add_child(bullet)
	bullet.global_position = self.global_position
	bullet.rotate_me(direction)
	
func _calculate_direction(velocity: Vector2):
	var angle = 0
	if (velocity.x > 0):
		angle = 0;
		
	if(velocity.x < 0):
		angle = 180
		
	if(velocity.y > 0):
		angle = 90
		
	if(velocity.y < 0):
		angle = 270
			
	return angle * PI/180	
		
