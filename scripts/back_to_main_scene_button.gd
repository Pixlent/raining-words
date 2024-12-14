extends Button

@onready var line_edit = $"../HBoxContainer/VBoxContainer/LineEdit"
@onready var h_slider = $"../HBoxContainer/VBoxContainer/HSlider"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	SceneManager.unload_game()
	SceneManager.main.v_box_container.show()
	SceneManager.main.settings.show()
	
	SceneManager.main.seed = line_edit.text
	SceneManager.main.tile_deletion_chance = h_slider.value
	pass # Replace with function body.
