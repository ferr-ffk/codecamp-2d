extends CharacterBody2D

class_name Jogador

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# @onready é para a variável ser usado apenas quando estiver pronto para uso
# após a inicialização
@onready var animacao = get_node("AnimationPlayer")

# animação quando o node estiver pronto
#func _ready():
	#animacao.play("idle")
	#
#func animacao_quando_pulando():
	#animacao.play("jump")
#
#func animacao_quando_caindo():
	#animacao.play("jump")
	#
#func animacao_quando_correndo():
	#animacao.play("run")

# a cada tick essa função é chamada
func _physics_process(delta):
	# Se não está no chão, puxa o jogador pra baixo
	if not is_on_floor():
		velocity.y += gravity * delta

	# Pega o input de pulo (padrão é a barra de espaço) e verifica se não
	# está no chão
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animacao.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
			
		if direction < 0: 
			get_node("AnimatedSprite2D").flip_h = true
		elif direction > 0:
			get_node("AnimatedSprite2D").flip_h = false
		
		# necessário para verificar se não está no meio do ar
		if velocity.y == 0:
			animacao.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# necessário para verificar se não está no meio do ar
		if velocity.y == 0:
			# necessário para quando o player parar de correr
			animacao.play("idle")

	# se está caindo (velocidade em y é positiva)
	if velocity.y > 0:
		animacao.play("fall")

	move_and_slide()
	
func _process(delta):
	if Game.playerHP <= 0:
		self.queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
	
func takeDamage():
	Game.playerHP -= 3
