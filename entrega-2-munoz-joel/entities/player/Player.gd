extends Sprite2D

@export var speed: float = 200.0
@export var projectile_scene: PackedScene = preload("res://projectile.tscn")

func _physics_process(delta: float) -> void:
	# Movimiento horizontal
	var direction_optimized: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	position.x += direction_optimized * speed * delta
	
	# La mano/cañón apunta al mouse
	$Cannon.look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	# Disparo con clic izquierdo del mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		fire()

func fire() -> void:
	if projectile_scene:
		var proj = projectile_scene.instantiate()
		proj.global_position = $Cannon/FirePosition.global_position
		var shoot_direction = ($Cannon/FirePosition.global_position).direction_to(get_global_mouse_position())
		proj.set_direction(shoot_direction)
		get_tree().root.add_child(proj)
