extends Node3D
class_name ItemConveyor

@onready var spawnPoint = $SpawnPoint;
@onready var itemHolder = $ItemHolder;

@export var items: Array[PackedScene];

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
    pass

func SpawnItem():
    var nextItem: Node3D = items.pick_random().instantiate();
    nextItem.position = spawnPoint.position;
    itemHolder.add_child(nextItem);
    
    pass
