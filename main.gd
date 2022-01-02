extends Node
signal gameover
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var lives = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$gameOver.hide()
	$startTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func _on_EnemyCrawler_hitby(laser):
	pass
	
func _on_startTimer_timeout():
	$Player.start($startPosition.position)

func _on_Player_hit():
	lives -= 1
	if lives == 0:
		emit_signal("gameover")
	else:
		$startTimer.start()

func _on_main_gameover():
	$gameOver.show()
	$quit.start()
	
	
func _on_quit_timeout():
	queue_free()
