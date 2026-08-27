extends CharacterBody2D
const VELOCIDAD = 300.0
func _physics_process(delta):
	var direccion = Input.get_axis("mover_izq", "mover_der")
	if direccion != 0:
		velocity.x = direccion * VELOCIDAD
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCIDAD)
	move_and_slide()
