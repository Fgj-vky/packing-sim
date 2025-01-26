extends DragableObject

@export var jumpTime: float;
@export var jumpForce: float;
var timer: float;

func _ready():
    timer = randf_range(jumpTime / 2, jumpTime * 1.5);
    super();

func _process(delta):
    timer -= delta;
    if(timer < 0):
        apply_central_impulse(Vector3(randf_range(-50,50), randf_range(jumpForce / 2, jumpForce * 1.5), randf_range(-50,50)) + -get_gravity());
        timer = randf_range(jumpTime / 2, jumpTime * 1.5);
    
    super(delta);