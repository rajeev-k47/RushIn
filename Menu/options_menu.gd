extends Control

class_name options_menu

@onready var exit_options_menu: Button = $MarginContainer/VBoxContainer/Exit_options_menu
 
signal exit_options_menu_signal

func _ready() -> void:
	exit_options_menu.button_down.connect(on_exit_options)
	set_process(false)
		
func on_exit_options():
	exit_options_menu_signal.emit()
	set_process(false)
