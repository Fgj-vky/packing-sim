extends Node
class_name GameController

@export var boxLocation: Node3D
@export var boxExitLocation: Node3D
@export var uiLayer: UiController
var currentBoxObject: Box = null

var boxSPrefab = preload("res://prefabs/box/boxSmall.tscn")
var boxMPrefab = preload("res://prefabs/box/boxMedium.tscn")

func createNewSBox():
	createNewBox(boxSPrefab)

func createNewMBox():
	createNewBox(boxMPrefab)

func createNewBox(boxScene: PackedScene): 
	if currentBoxObject != null:
		return
	var box = boxScene.instantiate() as Node3D
	get_tree().get_root().add_child(box)
	box.global_position = boxExitLocation.global_position
	currentBoxObject = box
	uiLayer.setCurrentBoxObject(currentBoxObject)
	var boxTween = get_tree().create_tween()
	boxTween.tween_property(box, "global_position", boxLocation.global_position, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	boxTween.tween_callback(Callable(currentBoxObject, "open"))
	
func closeCurrentBox():
	if currentBoxObject == null:
		return
	currentBoxObject.close()


func sendBoxAway():
	if currentBoxObject == null:
		return
	if currentBoxObject.isOpen:
		await currentBoxObject.close()
	var boxTween = get_tree().create_tween()
	boxTween.tween_property(currentBoxObject, "global_position", boxExitLocation.global_position, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)	
	await boxTween.finished
	currentBoxObject.queue_free()
	currentBoxObject = null
	uiLayer.setCurrentBoxObject(null)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
