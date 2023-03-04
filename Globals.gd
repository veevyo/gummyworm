extends Node

var foodScene = preload("res://Food.tscn")
var snakeScene = preload("res://Snake.tscn")
var gameOverScene = preload("res://GameOverOverlay.tscn")

onready var main = get_node("/root/Game")
onready var snake = get_node("/root/Game/Snake")
onready var highscoreLabel = get_node("/root/Game/Label")

var gridSize = Vector2(20,15)
var cellSize = 32
var highscore = 0

func eat_food():
	snake.add_segment();
	highscore += 1
	highscoreLabel.text = str(highscore).pad_zeros(2)
	place_food()

func place_food():
	var food = foodScene.instance()
	food.global_position = get_random_grid_pos()
	main.add_child(food)
	
func get_random_grid_pos():
	var possible_positions = []
	for x in gridSize.x:
		for y in gridSize.y:
			possible_positions.append(Vector2(x * cellSize, y * cellSize))
	
	for segment in snake.segments:
		possible_positions.erase(segment.global_position)
		
	randomize()
	possible_positions.shuffle()
	var random = possible_positions[0]
	return random

func reset_game():
	snake = snakeScene.instance()
	main.add_child(snake)
	reset_highscore()

func reset_highscore():
	highscore = 0
	highscoreLabel.text = "00"

func game_over():
	snake.queue_free()
	var overlay = gameOverScene.instance()
	main.add_child(overlay)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
