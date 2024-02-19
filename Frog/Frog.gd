extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var perseguindo = false

func _ready():
	get_node("AnimatedSprite2D").play("idle")


func _physics_process(delta):
	var animacao = get_node("AnimatedSprite2D")
	velocity.y += gravity * delta
	
	if perseguindo:
		if get_node("AnimatedSprite2D").animation != "death":
			animacao.play("jump")
			
		animacao.offset.y = -4.9
		player = get_node("../../Jogador/Jogador")
		var direction = (player.position - self.position).normalized()
		
		if direction.x > 0:
			animacao.flip_h = true
		else:
			animacao.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			animacao.play("idle")
		
		# reseta a velocidade e animação após o jogador sair de vista
		animacao.offset.y = 0
		velocity.x = 0
		
	move_and_slide()

# quando outro objeto entra no alcance da Area2d
func _on_player_detection_body_entered(body):
	if body.name == "Jogador":
		perseguindo = true
		
func _on_player_detection_body_exited(body):
	if body.name == "Jogador":
		perseguindo = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_death_body_entered(body):
	if body.name == "Jogador":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Jogador":
		perseguindo = false
		body.takeDamage()
		death()
		
func death():
	# para de perseguir o jogador para que a animação não fique andando
	velocity.x = 0
	perseguindo = false
	
	get_node("AnimatedSprite2D").play("death")
	
	# await serve para esperar o término de alguma função
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
