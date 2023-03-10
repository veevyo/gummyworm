extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("VBoxContainer/Label").text += str(Globals.highscore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Globals.reset_game()
	queue_free()


func _on_Button2_pressed():
	var user = get_node("LineEdit").get_text();
	SilentWolf.Scores.persist_score(user, Globals.highscore)
	Globals.reset_game()
	queue_free()
	#get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
