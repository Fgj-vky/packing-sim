extends Node3D

@onready var handle: Node3D = $"Lever Handle"

@export var activationTreshold = 10.0
@export var resetAngle = 5.0
var activated = false
signal onLeverPulled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var angle = handle.rotation_degrees.x
	if not activated:
		if angle >= activationTreshold:
			emit_signal("onLeverPulled")
			activated = true
	elif angle <= resetAngle:
		activated = false
	
