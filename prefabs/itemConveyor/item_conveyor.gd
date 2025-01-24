extends Node3D
class_name ItemConveyor

@onready var spawnPoint = $SpawnPoint;
@onready var itemHolder = $ItemHolder;

@export var items: Array[PackedScene];
var itemsOnBelt: Array[Node3D];
var itemsMoving = {};

@export var itemSpacing: float = 1
@export var conveyorSpeed: float = 1;

var timer: float;
var time = 2;

func _ready():
    timer = time;
    SpawnItem();
    pass

func _process(delta):
    timer -= delta;

    if(timer < 0):
        timer = time;
        SpawnItem();

    var itemsToRemove = [];
    for item : DragableObject in itemsMoving:
        var targetPos = itemsMoving[item];
        if(item.position.x >= targetPos.x || item.dragging):
            item.linear_velocity = Vector3(0,0,0);
            itemsToRemove.append(item);
            continue;
        
        item.linear_velocity = Vector3(conveyorSpeed, 0 ,0) + item.get_gravity();
        pass

    # Remove items that are no longer moved
    for item in itemsToRemove:
        itemsMoving.erase(item);
        pass
    
    # Remove items that are being dragged
    itemsOnBelt = itemsOnBelt.filter(func(item: DragableObject): return !item.dragging);
    pass

func SpawnItem():
    var nextItem: DragableObject = items.pick_random().instantiate() as DragableObject;
    nextItem.position = spawnPoint.position;
    itemHolder.add_child(nextItem);

    itemsOnBelt.append(nextItem);
    itemsMoving[nextItem] = position - Vector3(itemsOnBelt.size() * itemSpacing,0,0);
    pass
