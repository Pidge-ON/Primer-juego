extends CharacterBody2D

var can_laser: bool = true
var can_granade: bool= true 

signal laser(pos, direction) 
signal granade(pos, direction) 

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide() 
	
	#rotation
	look_at(get_global_mouse_position())
	
	var Player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser:
		$GPUParticles2D.emitting = true
		var laser_markers =$LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi()%laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start() 
		laser.emit(selected_laser.global_position, Player_direction)
	
	if Input.is_action_pressed("secondary action") and can_granade:
		can_granade = false
		$GranadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		granade.emit(pos, Player_direction)

func _on_timer_timeout() -> void:
	can_laser =true

func _on_timer_2_timeout() -> void:
	can_granade = true
