extends Node2D
class_name Grid

const TILE = preload("res://scenes/tile.tscn")
const GRID_SPACING: int = 150
const GRID_SIZE: int = 8

var tiles: Dictionary = {}
var selection: Array = []

@onready var game = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in GRID_SIZE:
		for y in GRID_SIZE:
			var tile = TILE.instantiate()
			tile.grid = self
			tile.pos = Vector2(x, y)
			tile.position = Vector2((x-(GRID_SIZE/2)) * GRID_SPACING, (y-(GRID_SIZE/2)) * GRID_SPACING)
			tiles.merge({Vector2(x, y):tile})
			add_child(tile)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_pressed("left_mouse_button"):
		var tile: Tile = get_tile_at_mouse_position()
		if !tile:
			return
		print(tile.position)
		tile.select()

func erase_tile(pos: Vector2):
	var tile = tiles.get(pos)
	
	if !tile:
		print("Tile doesn't exist: " + str(pos))
		return
	
	#tile.queue_free()
	#tiles.erase(pos)
	
	print("Tile selected: " + str(pos))

func get_tile(pos: Vector2):
	return tiles.get(pos)

func get_tile_at_mouse_position() -> Tile:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	var results = space.intersect_point(query)
	if results.size() < 1:
		return null
	var tile = results[0]["collider"].get_parent()
	
	if is_instance_of(tile, Tile):
		return tile
	return null
