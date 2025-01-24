extends Control
class_name UiController

@export var gameController: GameController
@onready var currentBoxLabel: Label = $HBoxContainer/Label
@onready var boxFillAmount: TextureProgressBar = $HBoxContainer/BoxFillBar
@onready var fade: TextureRect = $Fade;

# Called when the node enters the scene tree for the first time.
func _ready():
	boxFillAmount.visible = false;
	fade.modulate = Color.TRANSPARENT;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func setCurrentBoxObject(box: Node3D):
	if box == null:
		currentBoxLabel.text = "Current Box: None"
		boxFillAmount.visible = false;
	else:
		currentBoxLabel.text = "Current Box: %s" % box.name
		boxFillAmount.visible = true;
		var boxBox = box as Box;
		boxBox.fill_amount_changed.connect(updateBoxFillDisplay)

func updateBoxFillDisplay(amount: float):
	boxFillAmount.value = clamp((log(amount) + 2) * 50, 0, 100);
	pass

func _on_close_button_pressed():
	gameController.closeCurrentBox()

func _on_send_button_pressed():
	gameController.sendBoxAway()

func _on_m_button_pressed():
	gameController.createNewMBox()

func _on_s_button_pressed():
	gameController.createNewSBox()

func hideBoxFillDisplay():
	boxFillAmount.visible = false;

func fadeToBlack():
	var tween = fade.create_tween();
	tween.tween_property(fade, "modulate", Color.WHITE, 1);
	await tween.finished;
