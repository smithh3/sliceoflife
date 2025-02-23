extends PlayerSprite

class_name ComputerPlayerSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	grid_y_range = [GlobalConsts.GRID_Y / 2, GlobalConsts.GRID_Y]
	grid_pos = Vector2(GlobalConsts.GRID_X / 4, 0)
	position = CoordSystem.grid_coords_to_pixels(grid_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_turn() -> void:
	super()
	print("computer turn starting")
