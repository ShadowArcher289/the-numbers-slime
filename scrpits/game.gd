extends Node2D

@onready var slime: CharacterBody2D = $Slime
@onready var camera_2d: Camera2D = $Camera2D
@onready var results_label: Label = $ResultsLabel
@onready var manual_input: TextEdit = $Camera2D/ManualInput

var number_to_be_calculated := "";
var results = 0;

func _ready() -> void:
	SignalBus.number_input.connect(_add_to_calc, 3);
	SignalBus.backspace.connect(_backspace_from_calc);
	SignalBus.calculate.connect(_calculate_results);
	SignalBus.open_manual_input.connect(_manual_input);
	
	manual_input.hide();

func _process(delta: float) -> void:
	camera_2d.position = slime.position;
	
	if results == 0 && number_to_be_calculated != "":
		results_label.text = str(number_to_be_calculated); # updates the results_label to the current input
	else: 
		results_label.text = str(results); # updates the results_label to the output
	
	if manual_input.is_visible_in_tree(): # continuously run _manual_input() if manual_input is visible.
		_manual_input();

func _add_to_calc(value: int): # adds a given number to the list of numberrs
	number_to_be_calculated += str(value);
	print(number_to_be_calculated);

func _backspace_from_calc() -> void:
	if number_to_be_calculated != "": # if not empty already
		number_to_be_calculated = number_to_be_calculated.left(-1); # removes last number in the list

func _manual_input() -> void:
	manual_input.show();
	if Input.is_action_pressed("enter"):
		number_to_be_calculated = manual_input.text;
		_calculate_results();
		manual_input.hide();
	

func calculate(input: int): # converts the stored number_to_be_calculated into an int, calling number_sum with it and sets results to the output of number_sum
	results = number_sum(int(input));

func _calculate_results() -> void:
	calculate(int(number_to_be_calculated));

func number_sum(input: int): # calculates te math thing for the challenge
	var string_input = str(input);
	var data = string_input.split("");
	var output := 0;
	for i in data.size():
		if data[i] == data[i + 1]:
			output += int(data[i])/1;
		elif((i + 1 == data.size()) && (data[i] == data[0])): # checks for the final and beginning numbers
			output += data[i] / 1;
	return output;
