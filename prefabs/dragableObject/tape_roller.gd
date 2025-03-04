extends DragableTool

@onready var tapeDecal: Decal = $Decal2
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var gameController: GameController
var tapeSounds: Array[AudioStream] = [
	preload("res://sounds/tape1.wav"),
	preload("res://sounds/tape2.wav"),
	preload("res://sounds/tape3.wav"),
]

func useTool():
	if dragging:

		if gameController.currentBoxObject == null:
			return
		if gameController.currentBoxObject.isOpen:
			return;

		var space_state = get_world_3d().direct_space_state
		var from = global_transform.origin
		var to = from + Vector3.DOWN * 1000
		var query = PhysicsRayQueryParameters3D.new()
		query.from = from
		query.to = to
		query.collision_mask = 2 # Only collide with objects in layer 2
		var result = space_state.intersect_ray(query)
		if result:

			# Check if result is a Box by checking if it has layer 2
			
			if result.collider.collision_layer & 2 == 0:
				return

			var objectBelow = result.collider
			var objectBelowRoot = objectBelow.get_parent()

			# copy the tapeDecal to the object below
			var newDecal = Decal.new()
			newDecal.texture_albedo = tapeDecal.texture_albedo
			newDecal.set_transform(tapeDecal.get_transform())
			objectBelowRoot.add_child(newDecal)
			newDecal.global_position = tapeDecal.global_position
			newDecal.size = tapeDecal.size
			newDecal.global_rotation = tapeDecal.global_rotation
			newDecal.scale = tapeDecal.scale / objectBelowRoot.scale
			newDecal.cull_mask = tapeDecal.cull_mask

			# Move the tool down with impulse
			var impulse = Vector3.DOWN * 100
			# Add a bit of force relative to the rotation
			var angle = self.global_rotation.y
			impulse.x += sin(angle) * 100
			impulse.z += cos(angle) * 100


			self.apply_impulse(impulse)
			playTapeSound()
			gameController.currentBoxObject.tapeCount += 1

func playTapeSound():
	var randomAudio = tapeSounds[randi() % tapeSounds.size()]
	audioPlayer.stream = randomAudio
	audioPlayer.play()
