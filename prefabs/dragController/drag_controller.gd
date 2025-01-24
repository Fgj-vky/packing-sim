extends Node

var dragging: bool = false
var currentDragObject: DragableObject = null
var highlightedObject: DragableObject = null
var distance = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging and currentDragObject != null:
		var mousePos = get_viewport().get_mouse_position()
		var ray = get_viewport().get_camera_3d().project_ray_origin(mousePos)
		var target = ray + get_viewport().get_camera_3d().project_ray_normal(mousePos) * 3
		currentDragObject.set_global_transform(Transform3D(Basis(), target))

func isFree() -> bool:
	return dragging or highlightedObject != null

func setHighlighted(dragableObject: DragableObject) -> void:
	if highlightedObject != null:
		highlightedObject = null
	highlightedObject = dragableObject

func startDragging(dragableObject: DragableObject) -> void:

	if (dragging and dragableObject != null):
		dragging = false
		currentDragObject = null
		return
	dragging = true
	currentDragObject = dragableObject

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT :
			if (!dragging and highlightedObject != null):
				startDragging(highlightedObject)
	elif event is InputEventMouseButton and !event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if dragging:
				dragging = false
				currentDragObject = null