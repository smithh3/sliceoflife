extends Sprite2D

class_name PlayerSprite

var grid_y_range = []
signal end_turn
var tennis_ball: TennisBall
var square_clicked: Vector2i
var my_turn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tennis_ball = %TennisBall
	#print("player sprite connected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_turn() -> void:
	my_turn = true

func finish_turn() -> void:
	my_turn = false
	end_turn.emit()

func on_square_clicked(grid_loc: Vector2i) -> void:
	print("square clicked (this is player.gd)")
	if my_turn and grid_y_range.size() > 0:
		if grid_loc[1] >= grid_y_range[0] and grid_loc[1] <= grid_y_range[1]:
			tennis_ball.set_trajectory(grid_loc)
			#tennis_ball.move_to_grid_pos(grid_loc)
			finish_turn()
#func _on_square_clicked(grid_loc: Vector2i) -> void:
	#print("square clicked (this is player.gd)")
	#if my_turn and grid_y_range.size() > 0:
		#if grid_loc[1] >= grid_y_range[0] and grid_loc[1] <= grid_y_range[1]:
			#tennis_ball.move_to_grid_pos(grid_loc)
			#finish_turn()
