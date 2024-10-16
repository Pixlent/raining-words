extends Node2D

const TILE = preload("res://scenes/tile.tscn")
const GRID_SPACING: int = 150
const GRID_SIZE: int = 8

@onready var game = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in GRID_SIZE:
		for y in GRID_SIZE:
			var tile = TILE.instantiate()
			tile.position = Vector2((x-(GRID_SIZE/2)) * GRID_SPACING, (y-(GRID_SIZE/2)) * GRID_SPACING)
			add_child(tile)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
