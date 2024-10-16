extends Node2D

@onready var label = $Label

var random := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = String.chr(random.randi_range(65, 90))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_label_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_button"):
		print("left_click: " + str(position))
		queue_free()
	pass # Replace with function body.
