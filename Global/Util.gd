extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	# para salvar em json é necessário criar um dicionário da data
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold,
	}
	
	var jstr = JSON.stringify(data)
	file.store_line(jstr) 
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	if FileAccess.file_exists(SAVE_PATH):
		
		# se não está na última linha
		if not file.eof_reached():
			var linhaAtual = JSON.parse_string(file.get_line())
			
			if linhaAtual:
				Game.playerHP = linhaAtual["playerHP"]
				Game.playerGold = linhaAtual["playerGold"]
