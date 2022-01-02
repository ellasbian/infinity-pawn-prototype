extends KinematicBody2D
signal die

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 200
export var life = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	if life == 0:
		emit_signal("die")

func _on_EnemyCrawler_die():
	queue_free() # Replace with function body.


func _on_flash_timeout():
	show() # Replace with function body.

func _on_Area2D_body_entered(body):
	life -= 1
	$flash.start()
	hide()
