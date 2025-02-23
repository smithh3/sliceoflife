extends Node

var players = []
var current_player_index = 0

func _ready() -> void:
	var tennis_ball = %TennisBall
	players.append(%HumanPlayerSprite)
	players.append(%ComputerPlayerSprite)
	var court_sprite: CourtSprite = %CourtSprite
	court_sprite.square_clicked.connect(_on_square_clicked)
	start_turn()

func start_turn():
	var current_player = players[current_player_index]
	print("Starting turn for player:", current_player)
	current_player.take_turn()

func _process(delta: float) -> void:
	pass

func _end_turn() -> void:
	current_player_index = (current_player_index + 1) % players.size()
	start_turn()

func _on_square_clicked(grid_loc: Vector2i) -> void:
	players[current_player_index].on_square_clicked(grid_loc)
