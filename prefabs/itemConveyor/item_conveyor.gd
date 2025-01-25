extends Node3D
class_name ItemConveyor

@onready var spawnPoint = $SpawnPoint;
@onready var itemHolder = $ItemHolder;

@export var items: Array[PackedScene];
var itemsOnBelt: Array;
var itemsMoving = {};

@export var itemSpacing: float = 1
@export var conveyorSpeed: float = 1;

var timer: float;
@export var spawnRate = 2;

func _ready():
	timer = spawnRate;
	SpawnItem();
	pass

func _physics_process(delta):
	timer -= delta;

	if(timer < 0):
		timer = spawnRate;
		SpawnItem();

	for node in itemsOnBelt:
		if(!is_instance_valid(node)):
			continue;

		var item = node as DragableObject;
		item.linear_velocity = Vector3(conveyorSpeed, 0 ,0) + item.get_gravity();
		pass
	
	# Remove items that are being dragged
	itemsOnBelt = itemsOnBelt.filter(func(item: DragableObject): return !item.dragging);
	pass

func SpawnItem():
	var nextItem: DragableObject = items.pick_random().instantiate() as DragableObject;
	nextItem.position = spawnPoint.position;
	itemHolder.add_child(nextItem);

	itemsOnBelt.append(nextItem);
	pass
