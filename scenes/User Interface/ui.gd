extends CanvasLayer

@onready var laser_label : Label = $LaserCounter/VBoxContainer/Label 

@onready var granade_label: Label = $GranadeCounter/VBoxContainer/Label

func _ready() -> void:
	laser_label.text = "-"
	granade_label.text = "-"

func _on_player_laser_amount_change(amount: Variant) -> void: 
	if laser_label != null:
		laser_label.text = str(amount)


func _on_player_granade_amount_change(amount: Variant) -> void: 
	if  granade_label != null:
		granade_label.text = str(amount)
