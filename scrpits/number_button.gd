extends Button

@export var value = 0; # value for the button, default 0

@onready var boring_shack_image: Sprite2D = $BoringShackImage

@onready var darken_rect: ColorRect = $DarkenRect

@onready var click_delay: Timer = $ClickDelay

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

func _ready() -> void:
	boring_shack_image.hide();
	darken_rect.hide();
	SignalBus.slime_press.connect(_on_slime_press);
	#text = str(value); # temporary number to distinguish buttons
	match value: # set the icon depending on the value
		0:
			self.icon = preload("res://sprites/button_0.png");
		1:
			self.icon = preload("res://sprites/button_1.png");
		2:
			self.icon = preload("res://sprites/button_2.png");
		3:
			self.icon = preload("res://sprites/button_3.png");
		4:
			self.icon = preload("res://sprites/button_4.png");
		5:
			self.icon = preload("res://sprites/button_5.png");
		6:
			self.icon = preload("res://sprites/button_6.png");
		7:
			self.icon = preload("res://sprites/button_7.png");
		8:
			self.icon = preload("res://sprites/button_8.png");
		9:
			self.icon = preload("res://sprites/button_9.png");
		10:
			self.icon = preload("res://sprites/button_submit.png");
		11:
			self.icon = preload("res://sprites/button_delete.png");
		12:
			text = "BoringShack";
			self.icon = null;
			boring_shack_image.show();
			


func _on_slime_press() -> void: # sends signal to input a number into the current list
	if (ray_cast_2d.is_colliding() || ray_cast_2d_2.is_colliding()) && click_delay.is_stopped():
		click_delay.start(); # delay for clicks, so once evey x seconds
		if value == 12: # remove the last number in the list when the backspace button is pressed
			darken_rect.show();
			SignalBus.emit_signal("open_manual_input"); 
		elif value == 11: # remove the last number in the list when the backspace button is pressed
			darken_rect.show();
			SignalBus.emit_signal("backspace"); 
		elif value == 10: # run calculations when the submit button is pressed
			darken_rect.show();
			SignalBus.emit_signal("calculate");
		else:
			darken_rect.show();
			SignalBus.emit_signal("number_input", value);
			
		await click_delay.timeout;
		darken_rect.hide();
