class_name SettingsPanel

extends VBoxContainer

var settings_schema : Resource = null:
	set(new_schema):
		settings_schema = new_schema
		if not is_node_ready():
			await ready
		
		self.regenerate_controls()


func _ready():
	self.regenerate_controls()


func regenerate_controls():
	for child in get_children():
		child.queue_free() # clear old controls
	
	if not self.settings_schema:
		return

	for key in self.settings_schema.SETTINGS.keys():
		var meta = self.settings_schema.SETTINGS[key]
		var value = SettingsManager.settings.get(key, meta.default)
		
		var hbox_container := HBoxContainer.new()
		
		var label = Label.new()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		label.text = meta.label
		hbox_container.add_child(label)

		var control : Control
		match meta.type:
			"bool":
				control = CheckBox.new()
				control.button_pressed = value
				control.toggled.connect(func(val): _update_setting(key, val))
			"float":
				control = HSlider.new()
				control.min_value = meta.get("min", 0.0)
				control.max_value = meta.get("max", 1.0)
				control.step = meta.get("step", 0.01)
				control.value = value
				control.value_changed.connect(func(val): _update_setting(key, val))
			"enum":
				control = OptionButton.new()
				for option in meta.options:
					control.add_item(option)
				control.select(meta.options.find(value))
				control.item_selected.connect(func(idx): _update_setting(key, meta.options[idx]))
		
		control.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox_container.add_child(control)
		self.add_child(hbox_container)


func _update_setting(key, value):
	SettingsManager.settings[key] = value
	SettingsManager.save_settings()
