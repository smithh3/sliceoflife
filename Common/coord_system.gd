extends Node

static func grid_coords_to_pixels(grid_coords: Vector2) -> Vector2:
	return CourtSprite.get_pixel_coords(grid_coords[0], grid_coords[1])

static func mph_to_pps(speed_mph: float) -> float:
	var speed_mps = speed_mph / 2.237
	var speed_pps = speed_mps * GlobalConsts.PIXELS_PER_METRE
	return speed_pps

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
