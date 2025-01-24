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
