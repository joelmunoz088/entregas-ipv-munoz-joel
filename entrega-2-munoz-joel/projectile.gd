extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction * speed * delta

func set_direction(target_direction: Vector2) -> void:
	direction = target_direction.normalized()
	rotation = direction.angle()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
