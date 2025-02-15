extends Node2D

class_name CourtBlock


func _init(_position: Vector2, _texture: Texture2D):
	position = _position
	#texture = _texture

func draw_block():
	pass
	#texture = load("res://grass_cube.png")
	#if texture:
		#draw_texture(texture, position)

func _draw():
	pass
	#draw_texture(texture, position)
