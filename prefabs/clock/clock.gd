extends DragableObject

@onready var clockHand: MeshInstance3D = $MeshInstance3D/ClockHandMesh
@export var gameController: GameController

func _process(delta):
    clockHand.rotation.z = lerp(PI + PI/2.0, 0.0, 1 - gameController.dayTimer.time_left / gameController.dayTimer.wait_time)
    pass