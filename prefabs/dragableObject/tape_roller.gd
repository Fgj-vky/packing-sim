extends DragableTool

@onready var tapeDecal: Decal = $Decal2

func useTool():
	if dragging:
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
			newDecal.texture_albedo = tapeDecal.texture_albedo
			newDecal.set_transform(tapeDecal.get_transform())
			objectBelowRoot.add_child(newDecal)
			newDecal.global_position = tapeDecal.global_position
			newDecal.size = tapeDecal.size
			newDecal.global_rotation = tapeDecal.global_rotation
			newDecal.scale = tapeDecal.scale / objectBelowRoot.scale
			newDecal.cull_mask = tapeDecal.cull_mask

			# Move the tool down with impulse
			var impulse = Vector3.DOWN * 50
			# Add a bit of force relative to the rotation
			var angle = self.global_rotation.y
			impulse.x += sin(angle) * 20
			impulse.z += cos(angle) * 20


			self.apply_impulse(impulse)
