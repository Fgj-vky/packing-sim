extends Control
class_name UiController

@export var gameController: GameController
@onready var currentBoxLabel: Label = $HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func setCurrentBoxObject(box: Node3D):
	if box == null:
		currentBoxLabel.text = "Current Box: None"
	else:
		currentBoxLabel.text = "Current Box: %s" % box.name
	

func _on_close_button_pressed():
	gameController.closeCurrentBox()

func _on_send_button_pressed():
	gameController.sendBoxAway()

func _on_m_button_pressed():
	gameController.createNewMBox()

func _on_s_button_pressed():
	gameController.createNewSBox()
