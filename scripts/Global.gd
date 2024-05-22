extends Node

var transition_scene: PackedScene = preload("res://scenes/fade_in_canvas_layer.tscn")
var level_node: level
var enemies_killed: int = 0

var scenes_database: Dictionary = {
	"title": preload("res://scenes/title_screen.tscn"),
	"tavern": preload("res://scenes/tavern_scene.tscn"),
	"cave": preload("res://scenes/cave_scene.tscn"),
	"transition": null
}

@export_category("Spawner Variables")
@export var max_enemies = 10
@export var enemies_spawn = 0
var enemy_chicken = 0
var enemy_goblin = 0
var enemy_slime = 0
var enemy_skeleton = 0
var scene_forest = true  #quando for apara cena da caverna portal muda essa variavel para false
var scene_cave = true
var spawn_permission: bool = true


@export_category("Player Variables")
@export var damage_player: int = 1
@export var life_player: int = 3
@export var move_speed: float = 128
@export var total_xp: int = 100

func transitionToScene(destiny_scene: String) -> void:
	var trans = transition_scene.instantiate()
	trans.destiny_scene = scenes_database.get(destiny_scene) 
	add_child(trans)

func _process(delta):
	if life_player > 5:
		life_player = 5
