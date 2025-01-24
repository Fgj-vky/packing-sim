extends Node3D

@export var bubbleWrapScene: PackedScene;

var lastBubbleWrap: DragableObject;

func _ready():
	spawnBubbleWrap();
	pass

func spawnBubbleWrap():
	var bubbleWrap = bubbleWrapScene.instantiate() as DragableObject;
	add_child(bubbleWrap);
	bubbleWrap.picked_up.connect(onBubbleWrapTaken);
	lastBubbleWrap = bubbleWrap;
	pass

func onBubbleWrapTaken():
	lastBubbleWrap.picked_up.disconnect(onBubbleWrapTaken);
	spawnBubbleWrap();
