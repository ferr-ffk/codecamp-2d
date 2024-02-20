extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var texto = "Gold: %s"
	var vida = str(Game.playerGold)
	
	var label = texto % vida
	self.text = label
