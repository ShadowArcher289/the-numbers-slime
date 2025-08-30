extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var number_button_detector: Area2D = $NumberButtonDetector
@onready var collision_shape_2d: CollisionShape2D = $NumberButtonDetector/CollisionShape2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var number_button_collider: RayCast2D = $NumberButtonCollider


var SPEED = 300;
var SPRINT_SPEED = 600;
var jumping = false;
var fly = false;

func _process(delta: float) -> void:
	if fly: # fly mode
		if Input.is_action_just_pressed("move_left"):
			velocity.x -= SPEED;
		if Input.is_action_just_pressed("move_right"):
			velocity.x += SPEED;
		if Input.is_action_just_pressed("ui_down"):
			velocity.y += SPEED;
		if Input.is_action_just_pressed("ui_up"):
			velocity.y -= SPEED;
		move_and_slide();
	else:
		move(delta);

	if number_button_collider.is_colliding() && Input.is_action_pressed("select"):
		SignalBus.emit_signal("slime_press");

func move(delta: float) -> void: # runs player movement
	# sprinting
	var speed = SPEED;
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED;
	else:
		speed = SPEED;
	
	var directionX = Input.get_axis("move_left", "move_right");
	
	# vertical movement
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= 2000;
		
	#if ray_cast_2d.is_colliding(): # if colliding (presumably the ground) sets jump to false, allowing to jump again
	#	jumping = false;
	
	velocity.y += 100;
	
	#horizontal movement
	if directionX == -1: # Flip the sprite
		animated_sprite_2d.flip_h = false;
	elif directionX == 1:
		animated_sprite_2d.flip_h = true;
	
	velocity.x = directionX * speed; # horizontal movement
	#animated_sprite_2d.play("move");
	
	move_and_slide();
