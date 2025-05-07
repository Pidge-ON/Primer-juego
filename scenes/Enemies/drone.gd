extends CharacterBody2D

func _process(_delta): 
	var direction = Vector2(1,0) #puede ser .RIGHT tmb en vez de vector2
	
	velocity = direction * 500
	
	move_and_slide()
