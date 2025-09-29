extends Node

signal settings_saved

var save_file_name := "user://settings.json"
var settings_schema : Resource = null
var settings := {}

func _ready():
	load_settings()


func set_save_file_name(new_fname : String) -> void:
	self.save_file_name = new_fname


func load_settings():
	if not self.is_settings_schema_set():
		return
	
	if FileAccess.file_exists(self.save_file_name):
		var file = FileAccess.open(self.save_file_name, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY:
			settings = {}
			for key in self.settings_schema.SETTINGS.keys():
				var meta = self.settings_schema.SETTINGS[key]
				settings[key] = data.get(key, meta.default)
	else:
		reset_to_defaults()
	save_settings() # ensure missing keys are written


func save_settings():
	var file = FileAccess.open(self.save_file_name, FileAccess.WRITE)
	file.store_string(JSON.stringify(settings, "\t"))
	self.settings_saved.emit()


func reset_to_defaults():
	if not self.is_settings_schema_set():
		return
	
	settings = {}
	for key in self.settings_schema.SETTINGS:
		settings[key] = self.settings_schema.SETTINGS[key].default

func is_settings_schema_set() -> bool:
	if not self.settings_schema:
		push_error("LSG-settings: Settings schema not set for SettingsManager!")
		return false
	return true
