extends Button

@export var value = 0; # value for the button, default 0


func _ready() -> void:
	match value:
		0:
			self.icon = preload("res://icon.svg");

func _on_pressed() -> void:
	emit_signal("SignalBus.number_imput", value);
