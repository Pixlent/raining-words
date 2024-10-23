extends Node2D
class_name Tile

@onready var label = $Label
@onready var sprite_2d = $Sprite2D

@export var grid: Grid
@export var pos: Vector2

var random := RandomNumberGenerator.new()
var selected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = String.chr(random.randi_range(65, 90))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func select():
	if !selected:
		selected = true
		sprite_2d.show()
		grid.erase_tile(pos)
