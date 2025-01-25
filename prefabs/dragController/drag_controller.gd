extends Node

var dragging: bool = false
var currentDragObject: DragableObject = null
var highlightedObject: DragableObject = null
var distanceFromScreen = 3

@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D
var grabSound = preload("res://sounds/grab.wav")
var dropSound = preload("res://sounds/drop.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging and currentDragObject != null:
		var mousePos = get_viewport().get_mouse_position()
		var ray = get_viewport().get_camera_3d().project_ray_origin(mousePos)
		var target = ray + get_viewport().get_camera_3d().project_ray_normal(mousePos) * distanceFromScreen
		var difference = target - currentDragObject.global_transform.origin
		var direction = difference.normalized()
		var distance = difference.length()
		var max_accelaration = 1000
		var acceleration = direction * min(max_accelaration, distance * 100)

		currentDragObject.apply_force(acceleration)


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
	currentDragObject.linear_damp = 15
	currentDragObject.angular_damp = 15
	currentDragObject.pickUp();
	Input.set_custom_mouse_cursor(load("res://textures/Hand_Drag2.png"))
	audioPlayer.stream = grabSound
	audioPlayer.play()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT :
			if (!dragging and highlightedObject != null):
				startDragging(highlightedObject)
	elif event is InputEventMouseButton and !event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if dragging:
				dragging = false
				currentDragObject.linear_damp = 0
				currentDragObject.angular_damp = 0
				currentDragObject.release();
				currentDragObject = null
				Input.set_custom_mouse_cursor(load("res://textures/Hand2.png"))
				audioPlayer.stream = dropSound
				audioPlayer.play()
