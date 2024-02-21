extends Node2D

var Cherry = preload("res://Collectibles/Cherry/cherry.tscn")

func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	
	var rng = RandomNumberGenerator.new()
	
	var x = rng.randi_range(50, 560)
	
	cherryTemp.position = Vector2(x, 400)	
	get_node("Cherries").add_child(cherryTemp)

	
