extends Button

@onready var v_box_container = $"../VBoxContainer"
@onready var line_edit = $HBoxContainer/VBoxContainer/LineEdit
@onready var h_slider = $HBoxContainer/VBoxContainer/HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_settings_button_pressed():
	v_box_container.hide()
	hide()
	SceneManager.load_game("res://scenes/settings.tscn")
