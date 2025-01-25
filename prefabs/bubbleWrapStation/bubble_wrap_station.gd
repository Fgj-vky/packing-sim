extends Node3D

@onready var animationPlayer: AnimationPlayer = $"BubblewrapMachine/AnimationPlayer"

@export var wrappedItemScenes: Array[PackedScene];
@onready var spawnLocation: Node3D = $SpawnLocation

var currentItems: Array[DragableObject] = []

func activate():
	animationPlayer.play("Close")
	await animationPlayer.animation_finished
	var packedItems: Array[DragableObject] = []
	for item in currentItems:
		var packedItem = wrappedItemScenes.pick_random().instantiate()
		packedItem.itemName = item.itemName
		packedItem.itemSize = item.itemSize
		packedItem.global_transform = item.global_transform
		packedItems.append(packedItem)
		item.onRemoved()	
		item.queue_free()
	for packedItem in packedItems:
		get_parent().add_child(packedItem)	
	animationPlayer.play_backwards("Close")


func _on_area_3d_body_exited(body:Node3D):
	if body is DragableObject:
		currentItems.erase(body)

func _on_area_3d_body_entered(body:Node3D):
	if body is DragableObject:
		currentItems.append(body)


func _on_lever_on_lever_pulled():
	activate()
