extends Node2D

var Cherry = preload("res://Collectibles/Cherry/cherry.tscn")

# a cada vez que o timer acaba
func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	
	var rng = RandomNumberGenerator.new()
	
	var x = rng.randi_range(50, 560)
	
	cherryTemp.position = Vector2(x, 392)	
	get_node("Cherries").add_child(cherryTemp)

	
