extends Node2D
class_name level
var max_enemies: int 

@onready var player = $player as CharacterBody2D
@onready var camera := $Camera2D as Camera2D


func _ready():
	player.follow_camera(camera)
	Global.level_node = self
	Global.onTavern = false
	
func _on_ineventory_gui_closed():
	get_tree().paused = false

func _on_ineventory_gui_opened():
	get_tree().paused = true
