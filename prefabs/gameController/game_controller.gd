extends Node
class_name GameController

@export var boxLocation: Node3D
@export var boxExitLocation: Node3D
@export var uiLayer: UiController
var currentBoxObject: Box = null
@onready var audioPlayer = $AudioStreamPlayer3D
var boxSendAudio = preload("res://sounds/send.wav")

var boxSPrefab = preload("res://prefabs/box/boxSmall.tscn")
var boxMPrefab = preload("res://prefabs/box/boxMedium.tscn")

signal new_box_created(box:Box);
signal tried_to_close_full_box();

@onready var dayTimer: Timer = $DayTimer;
@export_file var dayChangeScene: String;

var currentOrder: Array[String] = []
var availableItems = ["melon", "book"]
@export var printer: Printer

func createNewOrder():
	if currentOrder.size() > 0:
		return
	var orderSize = randi() % 3 + 1
	for i in range(orderSize):
		var item = availableItems[randi() % availableItems.size()]
		currentOrder.append(item)
	uiLayer.updateOrderDisplay(currentOrder)
	printer.print()
	
	

func createNewSBox():
	createNewBox(boxSPrefab)

func createNewMBox():
	createNewBox(boxMPrefab)

func createNewBox(boxScene: PackedScene): 
	if currentBoxObject != null:
		return
	var box = boxScene.instantiate() as Node3D
	get_parent().add_child(box)
	box.global_position = boxExitLocation.global_position
	currentBoxObject = box
	var boxTween = get_tree().create_tween()
	boxTween.tween_property(box, "global_position", boxLocation.global_position, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	boxTween.tween_callback(Callable(currentBoxObject, "open"))
	new_box_created.emit(box);
	
func closeCurrentBox():
	if currentBoxObject == null:
		return
	if currentBoxObject.isBoxTooFull():
		tried_to_close_full_box.emit();
		return;
	if(!currentBoxObject.isOpen):
		return;
	
	currentBoxObject.close()

func sendBoxAway():
	if currentBoxObject == null:
		return
	if currentBoxObject.isBoxTooFull():
		tried_to_close_full_box.emit();
		return;
	if currentBoxObject.isOpen:
		await currentBoxObject.close()
	var boxTween = get_tree().create_tween()
	audioPlayer.stream = boxSendAudio
	audioPlayer.play()
	boxTween.tween_property(currentBoxObject, "global_position", boxExitLocation.global_position, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)	
	await boxTween.finished

	ProgressController.processBox(currentBoxObject, currentOrder);
	
	currentBoxObject.fill_amount_changed.emit(0);
	currentBoxObject.queue_free()
	currentBoxObject = null
	currentOrder = []
	createNewOrder()

func endDay():
	await uiLayer.fadeToBlack();
	get_tree().change_scene_to_file(dayChangeScene);
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	dayTimer.timeout.connect(endDay);
	await get_tree().create_timer(1.0).timeout
	createNewOrder()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
