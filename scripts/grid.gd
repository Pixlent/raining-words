extends Node2D
class_name Grid

const TILE = preload("res://scenes/tile.tscn")
const GAME_OVER = preload("res://scenes/game_over.tscn")
const GRID_SPACING: int = 150
const GRID_SIZE: int = 5

var seed: int = hash(SceneManager.main.seed)
var tile_deletion_chance: int = SceneManager.main.tile_deletion_chance
var tiles: Dictionary = {}
var selection: Array = []
var score: int = 0
var random: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var game = $".."
@onready var score_label = $"../Score"
@onready var word = $"../Word"

# Called when the node enters the scene tree for the first time.
func _ready():
	random.seed = seed
	WordDictionary.random.seed = seed
	
	for x in GRID_SIZE:
		for y in GRID_SIZE:
			place_tile(Vector2(x, y))
	
	var start_time = Time.get_ticks_msec()
	var words: Array[String] = WordDictionary.find_words(get_letters())
	var end_time = Time.get_ticks_msec()
	
	print(get_letters())
	print("Execution Time: " + str(end_time - start_time) + "ms")
	print(words)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("left_mouse_button"):
		left_click()
		
	if event.is_action_pressed("right_mouse_button"):
		right_click()

func left_click():
	var tile: Tile = get_tile_at_mouse_position()
	
	if !tile:
		return
	if !tile.selected:
		selection.append(tile)
		word.text = tiles_to_word(selection)
		tile.select()
	if selection.size() == 5:
		check_word()

func right_click():
	if selection.size() == 0:
		return
	var tile: Tile = selection[selection.size()-1]
	tile.deselect()
	selection.remove_at(selection.size()-1)
	word.text = tiles_to_word(selection)

func check_word():
	var word: String = tiles_to_word(selection)
	
	if WordDictionary.contains_word(word):
		score += 1
		score_label.text = "Score: " + str(score)
		
		for entry: Tile in selection:
			erase_tile(entry.pos)
			if random.randi_range(0, 100) > tile_deletion_chance:
				place_tile(entry.pos)
		
		var remaining_words: Array[String] = WordDictionary.find_words(get_letters())
		
		print(remaining_words)
		
		if remaining_words.size() < 1:
			game_over()
		
	else:
		print("Selection ended and word doesn't exist: " + word)
		for entry: Tile in selection:
			entry.deselect()
	
	selection.clear()

func game_over():
	game.add_child(GAME_OVER.instantiate())
	word.hide()
	self.hide()
	pass

func tiles_to_word(selection: Array) -> String:
	var word: String = ""
	
	for entry: Tile in selection:
		word += entry.label.text
	return word

func erase_tile(pos: Vector2):
	var tile = tiles.get(pos)
	
	if !tile:
		print("Tile doesn't exist: " + str(pos))
		return
	
	tile.queue_free()
	tiles.erase(pos)

func place_tile(pos: Vector2):
	var random_letter = WordDictionary.roll_random_letter().to_upper()
	var tile = TILE.instantiate()
	
	tile.grid = self
	tile.letter = random_letter
	tile.pos = Vector2(pos.x, pos.y)
	tile.position = Vector2((pos.x-(GRID_SIZE/2)) * GRID_SPACING, (pos.y-(GRID_SIZE/2)) * GRID_SPACING)
	tiles.merge({Vector2(pos.x, pos.y):tile})
	
	add_child(tile)

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

func get_letters() -> Array[String]:
	var letters: Array[String] = []
	
	for x in GRID_SIZE:
		for y in GRID_SIZE:
			if get_tile(Vector2(x, y)):
				letters.append(get_tile(Vector2(x, y)).letter.to_lower())
	return letters
