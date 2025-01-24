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

    for item : RigidBody3D in itemsMoving:
        var targetPos = itemsMoving[item];
        if(item.position.x >= targetPos.x):
            continue;
        item.move_and_collide(Vector3(conveyorSpeed * delta,0 ,0));

        pass
    pass

func SpawnItem():
    var nextItem: RigidBody3D = items.pick_random().instantiate() as RigidBody3D;
    nextItem.position = spawnPoint.position;
    itemHolder.add_child(nextItem);

    itemsOnBelt.append(nextItem);
    itemsMoving[nextItem] = position - Vector3(itemsOnBelt.size() * itemSpacing,0,0);
    
    pass
