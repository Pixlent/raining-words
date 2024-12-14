extends Control

@onready var line_edit = $HBoxContainer/VBoxContainer/LineEdit
@onready var h_slider = $HBoxContainer/VBoxContainer/HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	h_slider.value = SceneManager.main.tile_deletion_chance
	line_edit.text = SceneManager.main.seed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
