extends Control
@onready var Main := get_parent()

func _ready() -> void:
	$PanelContainer/VBoxContainer/Play.pressed.connect(Callable(Main, "play"))
	$PanelContainer/VBoxContainer/Play.pressed.connect(queue_free)
	$PanelContainer/VBoxContainer/Quit.pressed.connect(get_tree().quit)
