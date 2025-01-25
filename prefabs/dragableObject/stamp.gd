extends DragableTool
class_name Stamp

@onready var stampDecal: Decal = $Decal2
@onready var audioPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D
@export var gameController: GameController
var stampSound = preload("res://sounds/stamp.wav")

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
		var result = space_state.intersect_ray(query)
		if result:

			# Check if result is a Box by checking if it has layer 2
			
			if result.collider.collision_layer & 2 == 0:
				return

			var objectBelow = result.collider
			var objectBelowRoot = objectBelow.get_parent()

			# copy the tapeDecal to the object below
			var newDecal = Decal.new()
			newDecal.texture_albedo = stampDecal.texture_albedo
			newDecal.set_transform(stampDecal.get_transform())
			objectBelowRoot.add_child(newDecal)
			newDecal.global_position = stampDecal.global_position
			newDecal.size = stampDecal.size
			newDecal.global_rotation = stampDecal.global_rotation
			newDecal.scale = stampDecal.scale / objectBelowRoot.scale
			newDecal.cull_mask = stampDecal.cull_mask

			# Move the tool down with impulse
			var impulse = Vector3.DOWN * 150
			# Add a bit of force relative to the rotation

			self.apply_impulse(impulse)
			playStampSound()

func playStampSound():
	audioPlayer.stream = stampSound
	audioPlayer.play()
