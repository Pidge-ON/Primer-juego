extends Node2D

var laser_scene: PackedScene = preload("res://scenes/Proyectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/Proyectiles/granade.tscn")

func _on_gate_player_entered_gate(body) -> void:
	print("player has entered gate") 
	print(body)


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
