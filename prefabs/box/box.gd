extends Node3D
class_name Box

@onready var animPlayer: AnimationPlayer = $AnimationPlayer;
@onready var containerArea: Area3D = $BoxContainerArea;
@onready var closingParticles: GPUParticles3D = $ClosingParticles;

var isOpen: bool = false;
@export var containerSize: int = 3;

var itemsInTheBox: Array[DragableObject] = [];
var fillAmount: int = 0;

signal fill_amount_changed(new_value:float);

func _ready():
	containerArea.body_entered.connect(onObjectEntered);
	containerArea.body_exited.connect(onObjectRemoved);
	pass

func _process(delta):
	pass

func open():
	animPlayer.play("Open");
	isOpen = true;

func close():
	var fill = fillAmount;
	animPlayer.play_backwards("Open");
	if(itemsInTheBox.size() > 0):
		await get_tree().create_timer(0.1).timeout
		closingParticles.emitting = true;
		for item in itemsInTheBox:
			item.queue_free();
			pass
	await animPlayer.animation_finished;
	isOpen = false;
	fillAmount = fill;

func onObjectEntered(body: Node3D):
	if(body is not DragableObject):
		return;
	
	var item = body as DragableObject
	itemsInTheBox.append(item);
	fillAmount += item.itemSize;
	fill_amount_changed.emit(fillPrecentage())
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
		fill_amount_changed.emit(fillPrecentage())
		print("box is " + str(fillPrecentage() * 100) + "%% full!"); 
	pass

func isBoxTooFull() -> bool:
	return fillAmount > containerSize;
func fillPrecentage() -> float:
	return fillAmount as float / containerSize;
