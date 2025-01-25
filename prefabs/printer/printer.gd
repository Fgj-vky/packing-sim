extends RigidBody3D
class_name Printer

var receiptScene = preload("res://prefabs/dragableObject/variations/receipt.tscn")

@export var receiptSpawnLocation: Node3D
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D
# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass # Replace with function body.


# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func print():
	var receipt = receiptScene.instantiate() as Node3D
	get_parent().add_child(receipt)
	receipt.global_position = receiptSpawnLocation.global_position
	audioPlayer.play()
