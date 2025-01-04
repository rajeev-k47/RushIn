extends Control

class_name main_menu

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button

@onready var start_scence = preload("res://scenes/world.tscn") as PackedScene

func _ready() -> void:
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	
func on_start_pressed():
	get_tree().change_scene_to_packed(start_scence)
func on_exit_pressed():
	get_tree().quit()
