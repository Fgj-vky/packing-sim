extends Control
class_name UiController

@export var gameController: GameController
@export_file var mainMenuScene: String;
@onready var fade: TextureRect = $Fade;
@onready var orderList: VBoxContainer = $Panel2/MarginContainer/VBoxContainer/orderLabels
@onready var menu = $Menu;

# Called when the node enters the scene tree for the first time.
func _ready():
	fade.modulate = Color.TRANSPARENT;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func updateOrderDisplay(orders: Array[String]):
	for n in orderList.get_children():
		orderList.remove_child(n)
		n.queue_free()
	for order in orders:
		var label = Label.new()
		label.text = "- " + order.capitalize()
		orderList.add_child(label)




func _on_close_button_pressed():
	gameController.closeCurrentBox()

func _on_send_button_pressed():
	gameController.sendBoxAway()

func _on_m_button_pressed():
	gameController.createNewMBox()

func _on_s_button_pressed():
	gameController.createNewSBox()

func fadeToBlack():
	var tween = fade.create_tween();
	tween.tween_property(fade, "modulate", Color.WHITE, 1);
	await tween.finished;

func _on_quit_pressed():
	get_tree().change_scene_to_file(mainMenuScene);

func _on_resume_pressed():
		menu.visible = false;
		
func _input(event):
	if (event.is_action_pressed("pause")):
		menu.visible = !menu.visible;
		pass



