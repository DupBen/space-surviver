class_name Samus
extends CharacterBody2D


const SPEED := 50.0

@export var armor := 5

@onready var sprite := $Sprite2D as Sprite2D
@onready var hurtbox := $Hurtbox as Hurtbox
var face_direction := Vector2.RIGHT
var weapons = []
var passives = []
const beam_cannon = preload("res://src/weapons/BeamCannon.tscn")

func _ready() -> void:
	weapons.append(beam_cannon)
	for weapon in weapons:
		add_child(weapon.instantiate())


func _physics_process(_delta: float) -> void:
	move()


func move() -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	velocity = direction.normalized() * SPEED
	
	check_face_direction()
	move_and_slide()


func check_face_direction() -> void:
	var input_direction = Input.get_axis("left", "right")
	if input_direction > 0: 
		sprite.flip_h = false
		face_direction = Vector2.RIGHT
	if input_direction < 0:
		sprite.flip_h = true
		face_direction = Vector2.LEFT
 
func fire():
	pass