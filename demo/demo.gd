extends Control

@onready var settings_panel : SettingsPanel = $SettingsPanel

var SETTINGS_SCHEMA = preload("res://settings_schema.gd").new()

func _init() -> void:
	SettingsManager.settings_schema = SETTINGS_SCHEMA

func _ready() -> void:
	self.settings_panel.settings_schema = SETTINGS_SCHEMA
