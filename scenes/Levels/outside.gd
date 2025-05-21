extends LevelParent



func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property($Player,"speed",0,0.3)
	get_tree().change_scene_to_file("res://scenes/Levels/inside.tscn")
