extends Node2D

var bodyPart = preload("res://bodyPart.tscn");
onready var headPart = get_node("headPart");
var direction = Vector2(0,1);
var segments = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2(288,160)
	segments.append(headPart);
	for i in 3:
		var newPart = bodyPart.instance();
		segments.append(newPart);
		add_child(newPart);
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_down"):
		direction = Vector2(0,1);
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2(0,-1);
	if Input.is_action_just_pressed("ui_left"):
		direction = Vector2(-1,0);
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2(1,0);

func update_position():
	for x in range(segments.size()-1, -1, -1):
		if x == 0:
			segments[x].global_position += direction * 32;
		else:
			segments[x].global_position = segments[x-1].global_position;

func get_head_position():
	return segments[0].global_position;

func check_bounds():
	var headPos = get_head_position();
	var cellSize = 32;
	var gridSize = Vector2(20,15);
	if headPos.x >= gridSize.x * cellSize:
		segments[0].global_position.x = 0;
	if headPos.x < 0:
		segments[0].global_position.x = (gridSize.x-1)*cellSize
	if headPos.y >= gridSize.y * cellSize:
		segments[0].global_position.y = 0;
	if headPos.y < 0:
		segments[0].global_position.y = (gridSize.y-1)*cellSize
		
func check_game_over():
	for i in range(1, segments.size(),1):
		if segments[i].global_position == get_head_position():
			print("Game over!")
			Globals.game_over()

func add_segment():
	var newPart = bodyPart.instance();
	segments.append(newPart)
	add_child(newPart)
	newPart.global_position = Vector2(-64,-64)

func _on_Timer_timeout():
	update_position();
	check_bounds();
	check_game_over();
