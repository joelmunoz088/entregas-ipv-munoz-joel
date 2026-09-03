extends Node2D

@export var projectile_scene: PackedScene = preload("res://projectile.tscn")
var target: Node2D = null

func _ready() -> void:
	# Busca automáticamente al Player en la escena principal
	target = get_tree().root.find_child("Player", true, false)

func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		look_at(target.global_position)

func _on_shoot_timer_timeout() -> void:
	shoot()

func shoot() -> void:
	if projectile_scene and is_instance_valid(target):
		var proj = projectile_scene.instantiate()
		proj.global_position = $FirePosition.global_position
		
		# Calculamos el vector de dirección hacia el Player
		var dir = ($FirePosition.global_position).direction_to(target.global_position)
		proj.set_direction(dir)
		
		get_tree().root.add_child(proj)
