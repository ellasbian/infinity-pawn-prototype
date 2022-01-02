extends KinematicBody2D

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400

var screen_size
var shootingDisabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
	position.x = clamp(position.x, 49, screen_size.x - 369)
	position.y = clamp(position.y, 52, screen_size.y - 52)
	
	if Input.is_action_pressed("ui_accept"):
			if shootingDisabled == true:
				pass
			elif $bulletCooldown.is_stopped():
				var laserScene = load("res://Laser.tscn")
				var laser = laserScene.instance()
				get_parent().add_child(laser)
				laser.set_position(self.get_position())
				$bulletCooldown.start()

func start(pos):
	position = pos
	show()
	shootingDisabled = false
	$invulnCooldown.start()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies"):
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		emit_signal("hit")

func _on_Player_hit():
	shootingDisabled = true
	hide()
	

func _on_invulnCooldown_timeout():
	$Area2D/CollisionShape2D.set_disabled(false)


