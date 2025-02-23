extends Node

var GRID_X: int = 8
var GRID_Y: int = 16
var COURT_WIDTH_METRES: int = 10
var GRID_WIDTH: int = sqrt(pow(31, 2) + pow(5, 2))
var GRID_DEPTH: int = sqrt(pow(27, 2) + pow(16, 2))
var GRID_HEIGHT: int = 16
var PIXELS_PER_METRE: float = GRID_X * GRID_WIDTH / COURT_WIDTH_METRES
