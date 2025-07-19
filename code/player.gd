extends CharacterBody2D

signal HIT_ZAP

var zaps = 5


func _process(delta: float) -> void:
	zapper_control()



func zapper_control():
	
	var mousePos:Vector2 = get_global_mouse_position()
	var zap = $zapper
	var zapSprite = $zapper/Sprite2D
	zap.look_at(mousePos)
	if get_local_mouse_position().x >= position.x:
		zap.position.x = 18
		zapSprite.flip_h = false
		zapSprite.flip_v = false
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
		zap.position.x = -18
		zapSprite.flip_h = false
		zapSprite.flip_v = true
