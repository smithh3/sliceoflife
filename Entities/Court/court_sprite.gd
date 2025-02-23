extends Node2D

class_name CourtSprite

var grass_cube_texture = preload("res://Entities/Art/grass_cube.png")
var orange_cube_top = preload("res://Entities/Art/grid_select_top.png")

var court_blocks: Dictionary = {}
var selected_block: Vector2
var grid_loc: Vector2i = Vector2i(0, 0)

signal square_clicked(grid_loc: Vector2)

func _ready() -> void:
	for i in range(GlobalConsts.GRID_X):
		for j in range(GlobalConsts.GRID_Y):
			var pos = CoordSystem.get_pixel_coords(i, j) + Vector2(- CoordSystem.x_shift, 0)
			court_blocks[str(Vector2(i, j))] = CourtBlock.new(pos, grass_cube_texture)
	queue_redraw()

func _draw() -> void:
	for y in range(GlobalConsts.GRID_Y):
		for x in range(GlobalConsts.GRID_X):
			var block = court_blocks[str(Vector2(x, y))]
			draw_texture(grass_cube_texture, block.position)
			if selected_block == Vector2(x, y):
				draw_texture(orange_cube_top, block.position)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if court_blocks.has(str(grid_loc)):
			square_clicked.emit(grid_loc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_loc = get_viewport().get_mouse_position()
	grid_loc = CoordSystem.pixel_pos_to_grid_coords(mouse_loc[0], mouse_loc[1])
	
	if court_blocks.has(str(grid_loc)):
		selected_block = grid_loc
		queue_redraw()
	
