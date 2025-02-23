extends Node

var players: Array = []
var current_player_index: int = 0

func _ready() -> void:
	var tennis_ball = %TennisBall
	players.append(%HumanPlayerSprite)
	players.append(%ComputerPlayerSprite)
	var court_sprite: CourtSprite = %CourtSprite
	court_sprite.square_clicked.connect(_on_square_clicked)
	players[0].place_ball()
	start_turn()

func start_turn() -> void:
	var current_player = players[current_player_index]
	current_player.take_turn()

func _process(delta: float) -> void:
	pass

func _end_turn() -> void:
	current_player_index = (current_player_index + 1) % players.size()
	start_turn()

func _on_square_clicked(grid_loc: Vector2i) -> void:
	players[current_player_index].on_square_clicked(grid_loc)
