class_name Missile
extends Area2D

var speed := 250
var direction: Vector2
var velocity := Vector2.ZERO

func _ready() -> void:
	pass


func _physics_process(delta) -> void:
	velocity.x = direction.x * speed * delta
	velocity.y = direction.y * speed * delta
	translate(velocity)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_collision_counter_max_collisions_reached() -> void:
	queue_free()
