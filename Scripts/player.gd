extends CharacterBody2D

# Constantes de velocidad
const moveSpeed = 25
const maxSpeed = 50

# Constantes de salto
const jumpHeight = -300
const gravity = 15

# Referencias al sprite y a la animación
@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

# Esta función comprueba la pulsación de teclas en cada frame
func _physics_process(delta):
	# Se actualiza el eje y con la gravedad
	velocity.y += gravity
	
	# Se crea una variable para almacenar la fricion
	var friction = false
	
	# Movimiento horizontal (derecha, izquierda)
	if Input.is_action_pressed("ui_right"):
		# El sprite se invierte horizontalmente
		sprite.flip_h = true 
		
		# Se reproduce la animación de andar
		animationPlayer.play("Walk")
		
		# Se modifica la velocidad horizonal
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
	elif Input.is_action_pressed("ui_left"):
		# El sprite se invierte horizontalmente
		sprite.flip_h = false 
		
		# Se reproduce la animación de andar
		animationPlayer.play("Walk")
		
		# Se modifica el movimiento horizontal
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
	else:
		# Se activa la animación por defecto
		animationPlayer.play("Idle")
		
		# Se activa la fricción para detener el personaje
		friction = true
	
	# Se programa el salto
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jumpHeight
		if friction == true:
			# Se realiza un suavizado del motivmiento
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction == true:
			velocity.x = lerp(velocity.x, 0.0, 0.01)
	
	# Se realiza el movimiento
	move_and_slide()
		
