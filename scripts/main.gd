extends Control

@onready var v_box_container = $VBoxContainer
@onready var settings = $Settings

var seed: String = ""
var tile_deletion_chance: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SceneManager.hook_main(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
