extends Control

@onready var packedScenes := {
	"mainMenu" = preload("res://Assets/Scenes/main_menu.tscn"),
	"game" = preload("res://Assets/Scenes/game.tscn")
}
@onready var scenes := {
	"mainMenu" = null,
	"game" = null
}

func _ready() -> void:
	scenes.mainMenu = packedScenes.mainMenu.instantiate()
	add_child(scenes.mainMenu)

func play():
	scenes.game = packedScenes.game.instantiate()
	add_child(scenes.game)
