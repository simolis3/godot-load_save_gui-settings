@tool
extends EditorPlugin

const SETTINGS_PANEL_TYPE_NAME : String = "SettingsPanel"
const SETTINGS_MANAGER_TYPE_NAME : String = "SettingsManager"
const SETTINGS_PANEL_SCRIPT = preload("res://addons/LSG-Settings/settings_panel.gd")
const SETTINGS_MANAGER_SCRIPT = preload("res://addons/LSG-Settings/settings_manager.gd")
const SETTINGS_PANEL_ICON = preload("res://addons/LSG-Settings/settings_panel_icon.png")

func _enter_tree() -> void:
	add_custom_type(SETTINGS_PANEL_TYPE_NAME, "VBoxContainer", SETTINGS_PANEL_SCRIPT, SETTINGS_PANEL_ICON)
	add_autoload_singleton(SETTINGS_MANAGER_TYPE_NAME, SETTINGS_MANAGER_SCRIPT)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type(SETTINGS_PANEL_TYPE_NAME)
	remove_autoload_singleton(SETTINGS_MANAGER_TYPE_NAME)
