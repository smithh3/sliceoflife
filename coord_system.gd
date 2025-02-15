extends Node

static func grid_coords_to_pixels(grid_coords: Vector2) -> Vector2:
	return CourtSprite.get_pixel_coords(grid_coords[0], grid_coords[1])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
