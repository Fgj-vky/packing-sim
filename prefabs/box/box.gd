extends Node3D
class_name Box

@onready var animPlayer: AnimationPlayer = $AnimationPlayer;
@onready var containerArea: Area3D = $BoxContainerArea;

@export var containerSize: int = 3;

var itemsInTheBox: Array[DragableObject] = [];
var fillAmount: int = 0;

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
	
	var item = body as DragableObject
	itemsInTheBox.append(item);
	fillAmount += item.itemSize;
	print("box is " + str(fillPrecentage()) + "%% full!");
	pass

func onObjectRemoved(body: Node3D):
	if(body is not DragableObject):
		return;
		
	var item = body as DragableObject
	var itemIndex = itemsInTheBox.find(item);		
	if(itemIndex >= 0):
		itemsInTheBox.remove_at(itemIndex);
		fillAmount -= item.itemSize;
		print("box is " + str(fillPrecentage() * 100) + "%% full!"); 
	pass

func isBoxTooFull() -> bool:
	return fillAmount > containerSize;
func fillPrecentage() -> float:
	return fillAmount as float / containerSize;
