extends PlayerSprite

class_name HumanPlayerSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	grid_y_range = [0, GlobalConsts.GRID_Y / 2]
	var grid_pos = Vector2(GlobalConsts.GRID_X / 2, GlobalConsts.GRID_Y)
	position = CoordSystem.grid_coords_to_pixels(grid_pos)
	var ball_pos = grid_pos + Vector2(1, 0)
	tennis_ball.set_to_grid_pos(ball_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_turn() -> void:
	super()
