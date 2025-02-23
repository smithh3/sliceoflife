extends Node2D

static var theta_1: float = atan(27.0/16)
static var theta_2: float = atan(5.0/31)
static var alpha: float = PI - theta_1 - theta_2 #110
static var beta: float = theta_1 + PI / 2 #150
static var gamma: float = 2 * PI - alpha - beta

# x variation of top side of grid square
static var x_off: float = roundf(GlobalConsts.GRID_WIDTH * cos(gamma - PI / 2))
# y variation of top left side of grid square
static var y_off: float = roundf(GlobalConsts.GRID_DEPTH * sin(beta - PI / 2))
# x variation of top left side of grid square
static var x_shift: float = roundf(GlobalConsts.GRID_DEPTH * cos(beta - PI / 2))
# y variation of top side of grid square
static var y_shift: float = roundf(GlobalConsts.GRID_WIDTH * sin(gamma - PI / 2))

static var total_shift: Vector2

func _ready() -> void:
	calc_total_shift()

static func grid_coords_to_pixels(grid_coords: Vector2) -> Vector2:
	return get_pixel_coords(grid_coords[0], grid_coords[1])

static func get_grid_centre_offset() -> Vector2:
	return Vector2((x_off - x_shift) / 2, (y_off + y_shift) / 2)

static func get_pixel_coords(i: float, j: float) -> Vector2:
	return Vector2(i * x_off - j * x_shift, i * y_shift + j * y_off) + total_shift

static func mph_to_pps(speed_mph: float) -> float:
	var speed_mps = speed_mph / 2.237
	var speed_pps = speed_mps * GlobalConsts.PIXELS_PER_METRE
	return speed_pps

static func pixel_pos_to_grid_coords(x: float, y: float) -> Vector2i:
	var x_trans = x - total_shift[0]
	var y_trans = y - total_shift[1]
	var x_axis_angle = gamma - PI / 2
	var y_axis_angle = PI - beta
	var x_grid = (x_trans / cos(y_axis_angle)) + y_trans * sin(y_axis_angle) - x_trans * tan(y_axis_angle) * sin(y_axis_angle)
	var y_grid = (y_trans / cos(x_axis_angle)) - y_trans * tan(x_axis_angle) * sin(x_axis_angle) - x_trans * sin(x_axis_angle)
	var coords_out = Vector2i(x_grid / 29.1, y_grid / 29.3)
	return coords_out

func calc_total_shift() -> void:
	var max_x = x_shift + x_off * GlobalConsts.GRID_X
	var min_x = - x_shift * (GlobalConsts.GRID_Y - 1)
	var max_y = y_shift * GlobalConsts.GRID_X + y_off * GlobalConsts.GRID_Y + GlobalConsts.GRID_HEIGHT
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
