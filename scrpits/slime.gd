extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d_2: CollisionShape2D = $Area2D/CollisionShape2D2

var SPEED = 300;
var jumping = false;

func _process(delta: float) -> void:
	move(delta);


func move(delta: float) -> void: # runs player movement
	var directionX = Input.get_axis("move_left", "move_right");
	
	# vertical movement
	if !jumping && Input.is_action_pressed("jump"):
		jumping = true;
		velocity.y = -500;
		
		velocity.y += 500;
	velocity.y + 100
	
	#horizontal movement
	if directionX == -1: # Flip the sprite
		animated_sprite_2d.flip_h = false;
	elif directionX == 1:
		animated_sprite_2d.flip_h = true;
	
	velocity.x = directionX * SPEED; # horizontal movement
	#animated_sprite_2d.play("move");
	
	move_and_slide();
