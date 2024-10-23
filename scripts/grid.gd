extends Node2D
class_name Grid

const TILE = preload("res://scenes/tile.tscn")
const GRID_SPACING: int = 150
const GRID_SIZE: int = 5

var tiles: Dictionary = {}
var selection: Array = []

@onready var game = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	var possible_positions: Array = []
	
	for x in GRID_SIZE:
		for y in GRID_SIZE:
			possible_positions.append(Vector2(x, y))
	
	for i in 5:
		var word: String = WordDictionary.generate_random_word()
		
		print(word)
		
		for letter in 5:
			var random_pos: Vector2 = possible_positions.pick_random()
			var tile: Tile = TILE.instantiate()
			var random_letter: String = word[letter]
			
			random_letter = random_letter.to_upper()
			
			possible_positions.erase(random_pos)
			
			tile.letter = random_letter
			tile.grid = self
			tile.pos = random_pos
			tile.position = Vector2((random_pos.x-(GRID_SIZE/2)) * GRID_SPACING, (random_pos.y-(GRID_SIZE/2)) * GRID_SPACING)
			tiles.merge({random_pos:tile})
			add_child(tile)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		var tile: Tile = get_tile_at_mouse_position()
		if !tile:
			return
		if !tile.selected:
			selection.append(tile)
			tile.select()
		if selection.size() == 5:
			var word: String = ""
			for entry: Tile in selection:
				word = word + entry.label.text
			if WordDictionary.contains_word(word):
				print("Selection ended: " + word)
				for entry: Tile in selection:
					entry.queue_free()
					erase_tile(entry.pos)
			else:
				print("Selection ended and word doesn't exist: " + word)
				for entry: Tile in selection:
					entry.deselect()
			selection.clear()

func erase_tile(pos: Vector2):
	var tile = tiles.get(pos)
	
	if !tile:
		print("Tile doesn't exist: " + str(pos))
		return
	
	#tile.queue_free()
	#tiles.erase(pos)
	
	#print("Tile selected: " + str(pos) + " - " + str(tile.label.text))

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
