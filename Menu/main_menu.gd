extends Control

class_name main_menu

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_button
@onready var options_menu_ins = $Options_menu as options_menu
@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_scence = preload("res://present/present_main.tscn") as PackedScene

func _ready() -> void:
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_button.button_down.connect(on_options_pressed)
	options_menu_ins.exit_options_menu_signal.connect(exit_options)
	
func exit_options():
	margin_container.visible=true
	options_menu_ins.set_process(true)
	options_menu_ins.visible=false
	
func on_start_pressed():
	get_tree().change_scene_to_packed(start_scence)
func on_exit_pressed():
	get_tree().quit()

func on_options_pressed():
	options_menu_ins.visible=true
	margin_container.visible=false
