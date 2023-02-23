extends KinematicBody2D

const GRAVITY := 10
var jumpForce := 400

var velocity := Vector2.ZERO
var speed := 100

onready var anim := $Spr_player as AnimatedSprite
onready var screen_size = get_viewport_rect().size

func movement(delta):
	var input_direction = Input.get_axis("ui_left","ui_right")
	
	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction *speed, 0.5)
		anim.scale.x = -input_direction
	else:
		velocity.x = lerp(velocity.x,0,0.5)
	
	
	velocity.y += GRAVITY
	
	var collision = move_and_collide(velocity * delta)
	
	if velocity.y > 0:
		anim.play("fall")
	else:
		anim.play("idle")
	
	if collision:
		velocity.y = -jumpForce
		
func _physics_process(delta : float) -> void:
	movement(delta)
	
	position.x = wrapf(position.x,0,180)
	
	
