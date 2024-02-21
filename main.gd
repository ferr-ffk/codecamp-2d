extends Node2D

func _ready():
	Util.saveGame()
	Util.loadGame()

func _on_botao_sair_pressed():
	get_tree().quit()

func _on_botao_jogar_pressed():
	Util.loadGame() 
	
	# reseta a vida e ouro para quando ele morrer de vez
	if Game.playerHP <= 0:
		Game.playerHP = 10
		Game.playerGold = 0
		
	get_tree().change_scene_to_file("res://mundo.tscn")
