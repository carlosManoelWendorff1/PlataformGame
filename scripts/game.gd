extends Node2D

onready var platform_container := $plataform_container as Node2D
onready var platform_initial_position_y = $plataform_container/platform.position.y
onready var camera := $camera as Camera2D
onready var player := $KinematicBody2D as KinematicBody2D

export (PackedScene) var platform_scene

func level_generator(amount):
	
	for items in amount:
		platform_initial_position_y -= rand_range(36,54)
		var new_platform = platform_scene.instance() as StaticBody2D
		new_platform.position = Vector2(rand_range(20,160), platform_initial_position_y)
		platform_container.call_deferred("add_child",new_platform)
	print(amount)
	
func _ready() -> void :
	level_generator(10)

func _physics_process(delta:float) -> void:
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y


func _on_platform_cleaner_body_entered(body):
	body.queue_free()
	level_generator(1)
