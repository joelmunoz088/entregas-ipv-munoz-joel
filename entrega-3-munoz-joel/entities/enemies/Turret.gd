extends Sprite2D

@onready var fire_position: Node2D = $FirePosition
@onready var fire_timer: Timer = $FireTimer
@export var projectile_scene: PackedScene

var target: Node2D = null
var current_container: Node = null

func initialize(turret_pos: Vector2, _ignored_player: Node2D, p_container: Node) -> void:
	global_position = turret_pos
	self.current_container = p_container

func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		look_at(target.global_position)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		target = body
		fire_timer.start()

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		fire_timer.stop()

func _on_fire_timer_timeout() -> void:
	fire_at_player()

func fire_at_player() -> void:
	if projectile_scene and is_instance_valid(target):
		var proj_instance = projectile_scene.instantiate()
		var spawn_container = current_container if current_container else get_parent()
		var dir: Vector2 = (target.global_position - fire_position.global_position).normalized()
		
		proj_instance.initialize(
			spawn_container,
			fire_position.global_position,
			dir
		)
