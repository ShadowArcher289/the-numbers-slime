extends Button

@export var value = 0; # value for the button, default 0

@onready var darken_rect: ColorRect = $DarkenRect

@onready var click_delay: Timer = $ClickDelay

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

func _ready() -> void:
	darken_rect.hide();
	SignalBus.slime_press.connect(_on_slime_press);
	text = str(value); # temporary number to distinguish buttons
	match value: # set the icon depending on the value
		0:
			self.icon = preload("res://icon.svg");
		1:
			self.icon = preload("res://icon.svg");
		2:
			self.icon = preload("res://icon.svg");
		3:
			self.icon = preload("res://icon.svg");
		4:
			self.icon = preload("res://icon.svg");
		5:
			self.icon = preload("res://icon.svg");
		6:
			self.icon = preload("res://icon.svg");
		7:
			self.icon = preload("res://icon.svg");
		8:
			self.icon = preload("res://icon.svg");
		9:
			self.icon = preload("res://icon.svg");
		10:
			text = "Submit";
			self.icon = null;
		11:
			text = "Backspace";
			self.icon = null;
		12:
			text = "BoringShack";
			#self.icon = preload("res://icon.svg");
			self.icon = null;
			


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
