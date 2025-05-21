extends CharacterBody2D

var can_laser: bool = true
var can_granade: bool= true 

signal laser(pos, direction) 
signal granade(pos, direction)  

var laser_amount = 0
var granade_amount = 0

signal laser_amount_change(amount)
signal granade_amount_change(amount) 

var is_first_step = true

@export var max_speed: int = 500
var speed: int = max_speed 

func _ready(): 
	change_laser_amount(20)
	change_granade_amount(5)

func _process(_delta): 
	if is_first_step:
		laser_amount_change.emit(laser_amount)
		granade_amount_change.emit(granade_amount)
		is_first_step = false
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide() 
	
	#rotation
	look_at(get_global_mouse_position())
	
	var Player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and laser_amount > 0:
		#Globals.laser_amount -= 1
		change_laser_amount(-1)
		$GPUParticles2D.emitting = true
		var laser_markers =$LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi()%laser_markers.size()]
		can_laser = false
		$LaserReloadTimer.start() 
		laser.emit(selected_laser.global_position, Player_direction)
	
	if Input.is_action_pressed("secondary action") and can_granade and granade_amount > 0:
		#Globals.granade_amount -= 1
		change_granade_amount(-1) 
		can_granade = false
		$GranadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		granade.emit(pos, Player_direction)

func _on_timer_timeout() -> void:
	can_laser =true

func _on_timer_2_timeout() -> void:
	can_granade = true 

func change_laser_amount(delta):
	laser_amount = laser_amount + delta
	laser_amount_change.emit(laser_amount)

func change_granade_amount(delta):
	granade_amount = granade_amount + delta
	granade_amount_change.emit(granade_amount)
