extends CharacterBody2D

signal ZAP

var movement_speed = 75

var power:int = 30
@onready var energyBar = $TextureProgressBar

func _ready() -> void:
	$AnimationPlayer.play("startScene")
	energyBar.max_value = power

func _process(delta: float) -> void:
	Power()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("kill"):
		power=0
	if power <= 0:
		die()
		return
	var direction = Input.get_vector("left","right","up","down")
	
	if direction:
		velocity.x = direction.x * movement_speed
		velocity.y = direction.y * movement_speed
		$AnimationPlayer.play("move")
	else:
		velocity = velocity.move_toward(Vector2.ZERO,movement_speed)
		rotation_degrees = move_toward(rotation_degrees,0,delta)
		$AnimationPlayer.play("idle")
	flip_player()
	move_and_slide()

func get_dir() -> Vector2:
	var dir:Vector2
	dir = Input.get_vector("left","right","up","down")
	return dir

func flip_player():
	var direction = get_dir()
	if direction.x > 0: $Sprite2D.flip_h = false
	elif direction.x < 0: $Sprite2D.flip_h = true

func Power():
	energyBar.value = energyBar.max_value - power

func die():
	$AnimationPlayer.play("die")
	if $AnimationPlayer.animation_finished:
		print("Done dying")

func _on_hurt_timer_timeout() -> void:
	power -= 1
	print(power)
	$hurtTimer.start()

func change_scene(new_scene:String):
	$AnimationPlayer.play("changeScene")
	get_tree().change_scene_to_file(new_scene)

func zap():
	if Input.is_action_just_pressed("zap"):
		power -= 5
		emit_signal("ZAP")
