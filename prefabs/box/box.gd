extends Node3D
class_name Box

@onready var animPlayer: AnimationPlayer = $AnimationPlayer;
@onready var containerArea: Area3D = $BoxContainerArea;

var itemsInTheBox: Array[DragableObject] = [];

func _ready():
	containerArea.body_entered.connect(onObjectEntered);
	containerArea.body_exited.connect(onObjectRemoved);
	pass

func _process(delta):
	pass

func open():
	animPlayer.play("Open");

func close():
	animPlayer.play_backwards("Open");

func onObjectEntered(body: Node3D):
	if(body is not DragableObject):
		return;

	itemsInTheBox.append(body);
	pass

func onObjectRemoved(body: Node3D):
	if(body is not DragableObject):
		return;
	var itemIndex = itemsInTheBox.find(body);		
	if(itemIndex >= 0):
		itemsInTheBox.remove_at(itemIndex);
	pass