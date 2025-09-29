# settings_schema.gd
extends Resource

# A dictionary of all available settings and their metadata
var SETTINGS := {
	"test_toggle": {
		"type": "bool",
		"default": false,
		"label": "Test toggle"
	},
	"Test Slider": {
		"type": "float",
		"default": 0.8,
		"label": "Test slider",
		"min": 0.0,
		"max": 10.0,
		"step": 0.05
	},
	"difficulty": {
		"type": "enum",
		"default": "Normal",
		"label": "Difficulty",
		"options": ["Easy", "Normal", "Hard"]
	}
}
