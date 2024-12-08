extends Node2D
class_name Tile

@onready var label = $Word
@onready var sprite_selected = $Selected
@onready var sprite_texture = $Texture

@export var grid: Grid
@export var pos: Vector2

var letter: String = "?"
var random := RandomNumberGenerator.new()
var selected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = letter # String.chr(random.randi_range(65, 90))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select():
	if !selected:
		selected = true
		sprite_selected.show()
		sprite_texture.hide()

func deselect():
	if selected:
		selected = false
		sprite_selected.hide()
		sprite_texture.show()
