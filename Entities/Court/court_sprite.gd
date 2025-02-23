extends Node2D

class_name CourtSprite

var grass_cube_texture = preload("res://Entities/Art/grass_cube.png")
var orange_cube_top = preload("res://Entities/Art/grid_select_top.png")
var tile_size = Vector2(48, 48)
var court_blocks: Dictionary = {}
static var theta_1 = atan(27.0/16)
static var theta_2 = atan(5.0/31)
static var alpha = PI - theta_1 - theta_2 #110
static var beta = theta_1 + PI / 2 #150
static var gamma = 2 * PI - alpha - beta
static var width = sqrt(pow(31, 2) + pow(5, 2))
static var depth = sqrt(pow(27, 2) + pow(16, 2))
var height = 16

static var x_off = roundf(width * cos(gamma - PI / 2))
static var y_off = roundf(depth * sin(beta - PI / 2))
static var x_shift = roundf(depth * cos(beta - PI / 2))
static var y_shift = roundf(width * sin(gamma - PI / 2))
static var total_shift: Vector2
var selected_block: Vector2
var grid_loc: Vector2i = Vector2i(0, 0)
signal square_clicked
#var pixels_per_metre = GlobalConsts.GRID_X * GlobalConsts.GRID_Y / 8
#var pixels_per_metre = GlobalConsts.GRID_X * width / 

func get_grid_centre_offset():
	return Vector2((x_off - x_shift) / 2, (y_off + y_shift) / 2)

static func get_pixel_coords(i, j):
	return Vector2(i * x_off - j * x_shift, i * y_shift + j * y_off) + total_shift
	#return Vector2(i * width * cos(gamma) - j * depth * cos(beta), i * sin(gamma) + j * sin(beta))
	
static func attempt_n_plus_1(x, y):
	var x_trans = x - total_shift[0]# - x_shift
	var y_trans = y - total_shift[1]
	var x_axis_angle = gamma - PI / 2 # checked
	var y_axis_angle = PI - beta # checked
	var x_grid = (x_trans / cos(y_axis_angle)) + y_trans * sin(y_axis_angle) - x_trans * tan(y_axis_angle) * sin(y_axis_angle)
	var y_grid = (y_trans / cos(x_axis_angle)) - y_trans * tan(x_axis_angle) * sin(x_axis_angle) - x_trans * sin(x_axis_angle)
	var coords_out = Vector2i(x_grid / 29.1, y_grid / 29.3)
	return coords_out
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var max_x = x_shift + x_off * GlobalConsts.GRID_X
	var min_x = - x_shift * (GlobalConsts.GRID_Y - 1)
	var max_y = y_shift * GlobalConsts.GRID_X + y_off * GlobalConsts.GRID_Y + height
	var min_y = 0
	
	# first shift to center origin block
	# because blocks are drawn at top left
	var x_shift_0 = (x_off + x_shift) / 2
	var y_shift_0 = (y_off + y_shift) / 2
	# next shift to center grid at origin
	var x_shift_1 = (max_x + min_x) / 2
	var y_shift_1 = (max_y + min_y) / 2
	# next shift to center of the screen
	var x_shift_2 = get_viewport_rect().size[0] / 2
	var y_shift_2 = get_viewport_rect().size[1] / 2
	
	total_shift = Vector2(- x_shift_1 + x_shift_2, - y_shift_1 + y_shift_2)
	
	for i in range(GlobalConsts.GRID_X):
		for j in range(GlobalConsts.GRID_Y):
			var pos = get_pixel_coords(i, j) + Vector2(- x_shift, 0)
			court_blocks[str(Vector2(i, j))] = CourtBlock.new(pos, grass_cube_texture)
	
	queue_redraw()

func _draw():
	#draw_rect(Rect2(100, 100, 32, 32), Color(1, 0, 0))
	#draw_texture(texture, Vector2(0, 0))
	for y in range(GlobalConsts.GRID_Y):
		for x in range(GlobalConsts.GRID_X):
			#court_blocks[str(Vector2(x, y))].queue_redraw()
			var block = court_blocks[str(Vector2(x, y))]
			draw_texture(grass_cube_texture, block.position)
			if selected_block == Vector2(x, y):
				draw_texture(orange_cube_top, block.position)
			
			
	#for block in court_blocks.values():
		#draw_texture(texture, block.position)
		#block.draw_block()
	
func _input(event):
	if event is InputEventMouse and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if court_blocks.has(str(grid_loc)):
			square_clicked.emit(grid_loc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_loc = get_viewport().get_mouse_position()
	#mouse_loc[0] = 44
	#mouse_loc[1] = 1
	#var grid_loc = get_court_coords(mouse_loc[0], mouse_loc[1])
	grid_loc = attempt_n_plus_1(mouse_loc[0], mouse_loc[1])
	#print(str(grid_loc))
	
	if court_blocks.has(str(grid_loc)):
		selected_block = grid_loc
		queue_redraw()
	
