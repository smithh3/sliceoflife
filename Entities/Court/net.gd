extends Node2D

var net_left_texture = preload("res://Entities/Art/net_left.png")
var net_mid_texture = preload("res://Entities/Art/net_mid.png")
var net_right_texture = preload("res://Entities/Art/net_right.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	var net_y_grid = - 2 +  GlobalConsts.GRID_Y / 2
	var net_x_grid = - 2
	var reposition_offset = Vector2(net_left_texture.get_width(), net_left_texture.get_height())
	var pixel_coords = CoordSystem.get_pixel_coords(net_x_grid, net_y_grid)
	draw_texture(net_left_texture, pixel_coords)
	# strange hardcoded float values are from trial and error lining up the net
	# will need to fix this using maths
	var last_coords = Vector2(net_x_grid, net_y_grid) + Vector2(0.08, - 0.27)
	for i in range(GlobalConsts.GRID_X - 1):
		draw_texture(net_mid_texture, Vector2i(CoordSystem.get_pixel_coords(last_coords[0] + 1, last_coords[1])))
		last_coords[0] += 1
	draw_texture(net_right_texture, Vector2i(CoordSystem.get_pixel_coords(last_coords[0] + 1.45, last_coords[1] + 0.24)))
		
	
	
