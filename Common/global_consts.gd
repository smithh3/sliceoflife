extends Node

var GRID_X = 8
var GRID_Y = 16
var COURT_WIDTH_METRES = 10
static var width = sqrt(pow(31, 2) + pow(5, 2))
var PIXELS_PER_METRE = GRID_X * width / COURT_WIDTH_METRES
