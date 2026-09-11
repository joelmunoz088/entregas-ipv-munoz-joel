extends CharacterBody2D

@onready var cannon: Node = $Cannon

@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -450.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var projectile_container: Node

func initialize(projectile_container: Node) -> void:
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container

func _physics_process(delta: float) -> void:
	# 1. Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Salto con espacio
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Movimiento horizontal
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# 4. Cañón apuntando al puntero
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)

	# 5. Disparo
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()
