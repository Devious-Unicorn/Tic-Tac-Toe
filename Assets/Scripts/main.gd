extends Control

@onready var packedScenes := {
	"mainMenu" = preload("res://Assets/Scenes/main_menu.tscn")
}
@onready var scenes := {
	"mainMenu" = null
}

func _ready() -> void:
	scenes.mainMenu = packedScenes.mainMenu.instantiate()
	add_child(scenes.mainMenu)
