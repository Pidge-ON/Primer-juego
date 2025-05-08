extends Node2D

var laser_scene: PackedScene = preload("res://scenes/Proyectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/Proyectiles/granade.tscn")

func _on_gate_player_entered_gate(_body) -> void:
		var tween = create_tween()
		tween.tween_property($Player,"speed",0,0.4)
	


func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees =rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Proyectiles.add_child(laser)


func _on_player_granade(pos, direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * 200
	$Proyectiles.add_child(granade)


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom",Vector2(1,1),1)


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D,"zoom",Vector2(0.6,0.6),2).set_trans(Tween.TRANS_LINEAR)
