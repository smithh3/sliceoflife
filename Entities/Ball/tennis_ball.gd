extends Sprite2D


class_name TennisBall


var start_pos = Vector2(0, 0)
var target_pos = Vector2(0, 0)
var velocity = Vector2(0, 0)
var moving = false
var height = 0
var position_2d = Vector2(0, 0)
#@onready var court_sprite = %CourtSprite
var court_sprite: CourtSprite


func set_to_grid_pos(grid_pos):
	var pixel_pos = court_sprite.get_pixel_coords(grid_pos[0], grid_pos[1])
	position = Vector2i(pixel_pos + court_sprite.get_grid_centre_offset())
	position_2d = position
	print(str(position))

func update_height(new_height):
	height = new_height
	position = position_2d + Vector2(0, -height)

func move_to_grid_pos(grid_pos):
	target_pos = court_sprite.get_pixel_coords(grid_pos[0], grid_pos[1])
	target_pos += court_sprite.get_grid_centre_offset()
	var SPEED_100 = court_sprite.pixels_per_metre * 44
	var speed = randi_range(SPEED_100 * 0.6, SPEED_100 * 1.2)
	
	velocity = (target_pos - position_2d).normalized() * speed
	moving = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	court_sprite = %CourtSprite
	update_height(40)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if moving:
		if abs(target_pos[0] - position_2d[0]) > abs(velocity[0] * delta):
			position_2d += velocity * delta
		else:
			position_2d = target_pos
			velocity = 0
			moving = false
			height = 0
	position = Vector2i(position_2d + Vector2(0, -height))

func _process(delta: float) -> void:
	pass

func _draw() -> void:
	draw_line(position - global_position, target_pos - global_position, Color.NAVY_BLUE, 4)
	

func set_trajectory(grid_target: Vector2) -> void:
	target_pos = CoordSystem.grid_coords_to_pixels(grid_target)
	queue_redraw()

func _on_square_clicked(grid_pos: Vector2) -> void:
	pass
