@tool
extends EditorPlugin

const SETTINGS_PANEL_TYPE_NAME : String = "SettingsPanel"
const SETTINGS_MANAGER_TYPE_NAME : String = "SettingsManager"


func _enter_tree() -> void:
	add_custom_type(SETTINGS_PANEL_TYPE_NAME, "VBoxContainer", preload("settings_panel.gd"), preload("settings_panel_icon.png"))
	add_autoload_singleton(SETTINGS_MANAGER_TYPE_NAME, "settings_manager.gd")


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type(SETTINGS_PANEL_TYPE_NAME)
	remove_autoload_singleton(SETTINGS_MANAGER_TYPE_NAME)
