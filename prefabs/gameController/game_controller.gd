extends Node

@export var boxLocation: Node3D
@export var boxExitLocation: Node3D
var currentBoxObject: Box = null


var boxMPrefab = preload("res://prefabs/box/boxMedium.tscn")

func createNewMBox(): 
	if currentBoxObject != null:
		return
	var box = boxMPrefab.instantiate() as Node3D
	get_tree().get_root().add_child(box)
	box.global_position = boxExitLocation.global_position
	currentBoxObject = box
	var boxTween = get_tree().create_tween()
	boxTween.tween_property(box, "global_position", boxLocation.global_position, 2)
	boxTween.tween_callback(Callable(currentBoxObject, "open"))
	

func sendBoxAway():
	if currentBoxObject == null:
		return
	currentBoxObject.close()
	var boxTween = get_tree().create_tween()
	boxTween.tween_property(currentBoxObject, "global_position", boxExitLocation.global_position, 2)
	await boxTween.finished
	currentBoxObject.queue_free()
	currentBoxObject = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
