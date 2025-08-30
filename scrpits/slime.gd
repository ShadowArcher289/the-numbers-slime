extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var number_button_detector: Area2D = $NumberButtonDetector
@onready var collision_shape_2d: CollisionShape2D = $NumberButtonDetector/CollisionShape2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var number_button_collider: RayCast2D = $NumberButtonCollider

@onready var jump_timer: Timer = $JumpTimer

var SPEED = 300;
var SPRINT_SPEED = 600;
var jumping = false;
var fly = false;
var gravity = 100;

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

	if number_button_collider.is_colliding() && Input.is_action_pressed("select") && (animated_sprite_2d.animation != "splat"):
		animated_sprite_2d.play("splat");
		await get_tree().create_timer(0.2).timeout
		self.position.y -= 30;
		gravity = 0;
		await get_tree().create_timer(0.1).timeout
		SignalBus.emit_signal("slime_press");
		await get_tree().create_timer(0.4).timeout
		gravity = 100;
		#await get_tree().create_timer(0.1).timeout
		#self.position.y += 20;

func move(delta: float) -> void: # runs player movement
	# sprinting
	var speed = SPEED;
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED;
	else:
		speed = SPEED;
	
	var directionX = Input.get_axis("move_left", "move_right");
	
	# vertical movement
	if Input.is_action_pressed("jump") && is_on_floor() && jump_timer.is_stopped():
		jump_timer.start();
		animated_sprite_2d.play("jump");
		await get_tree().create_timer(0.2).timeout;
		velocity.y -= 2000;
	
	#if ray_cast_2d.is_colliding(): # if colliding (presumably the ground) sets jump to false, allowing to jump again
	#	jumping = false;
	velocity.y += gravity;
	
	velocity.x = directionX * speed; # horizontal movement
	
	#animations
	# will not play animations if splatting
	if directionX == 1 && (animated_sprite_2d.animation != "splat"): # Flip the sprite
		#animated_sprite_2d.flip_h = false;
		if is_on_floor():
			if !animated_sprite_2d.is_playing(): # does not play running animation if another animation is going, this helps the jump animation to work
				animated_sprite_2d.play("move_right");
		else:
			animated_sprite_2d.play("look_right_air");
	elif directionX == -1 && (animated_sprite_2d.animation != "splat"):
		if is_on_floor():
			if !animated_sprite_2d.is_playing():
				animated_sprite_2d.play("move_left");
		else:
			animated_sprite_2d.play("look_left_air");
	else:
		if is_on_floor():
			if !animated_sprite_2d.is_playing():
				animated_sprite_2d.play("idle");
		elif animated_sprite_2d.animation != "splat":
			animated_sprite_2d.play("look_up_air");
	
	move_and_slide();
