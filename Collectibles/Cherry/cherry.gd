extends Area2D


func _on_body_entered(body):
	if body.name == "Jogador":
		# adiciona 3 de vida, limitando em 10 a vida final
		Game.playerHP = min(10, (Game.playerHP + 3))

		# cria-se dois tweens para executar os dois ao mesmo tempo
		var tweenPosicao = get_tree().create_tween()
		var tweenOpacidade = get_tree().create_tween()
		
		# serve para cereja flutuar no ar
		tweenPosicao.tween_property(self, "position", position - Vector2(0, 25), .3)
		
		# diminui a opacidade do node do padrão até 0
		tweenOpacidade.tween_property(self, "modulate:a", 0, .3)
		
		# função para quando terminar de executar as propriedades
		tweenPosicao.tween_callback(queue_free)
