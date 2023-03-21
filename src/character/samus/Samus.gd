class_name Samus
extends CharacterBody2D


const SPEED := 50.0
const beam_cannon = preload("res://src/weapons/Beam/BeamCannon.tscn")
const ice_beam_cannon = preload("res://src/weapons/IceBeam/IceBeamCannon.tscn")
const wave_beam_cannon = preload("res://src/weapons/WaveBeam/WaveBeamCannon.tscn")
const plasma_beam_cannon = preload("res://src/weapons/PlasmaBeam/PlasmaBeamCannon.tscn")
const spazer_beam_cannon = preload("res://src/weapons/SpazerBeam/SpazerBeamCannon.tscn")
const missile_cannon = preload("res://src/weapons/Missile/MissileCannon.tscn")
const super_missile_cannon = preload("res://src/weapons/SuperMissile/SuperMissileCannon.tscn")
const bomb_dropper = preload("res://src/weapons/Bomb/BombDropper.tscn")

@export var armor := 5

@onready var sprite := $Sprite2D as Sprite2D
@onready var hurtbox := $Hurtbox as Hurtbox
@onready var animation_player := $AnimationPlayer as AnimationPlayer

var face_direction := Vector2.RIGHT
var weapons = []
var passives = []

var is_moving = false;

func _ready() -> void:
    set_as_top_level(true)
    Globals.Player = self
    #weapons.append(beam_cannon)
    #weapons.append(ice_beam_cannon)
    #weapons.append(wave_beam_cannon)
    #weapons.append(plasma_beam_cannon)
    weapons.append(spazer_beam_cannon)
    #weapons.append(missile_cannon)
#    weapons.append(super_missile_cannon)
#    weapons.append(bomb_dropper)
    for weapon in weapons:
        add_child(weapon.instantiate())

    Events.levelled_up.connect(_on_levelled_up)


func _physics_process(_delta: float) -> void:
    move()
    handle_animation()
#	print($Health.health)

func _on_levelled_up(level: int)-> void:
    print("Level: ", level)


func handle_animation() -> void:
    #TODO handle death animation.
    var animation = "idle_right"
    if is_moving:
        animation = "walk"
    animation_player.play(animation)


func move() -> void:
    var direction := Vector2.ZERO
    var x_dir = Input.get_axis("left", "right")
    var y_dir = Input.get_axis("up", "down")

    is_moving = x_dir != 0 || y_dir != 0

    direction.x = x_dir
    direction.y = y_dir
    velocity = direction.normalized() * SPEED

    check_face_direction(direction.x)
    move_and_slide()


func check_face_direction(input_direction) -> void:
    if input_direction > 0:
        sprite.flip_h = false
        face_direction = Vector2.RIGHT
    if input_direction < 0:
        sprite.flip_h = true
        face_direction = Vector2.LEFT

func fire():
    pass
