@tool
extends Node

const PaletteResource = preload("res://Skin Maker/New Color Maker/Skins/New Color ressources/palette_resource.gd")

# Paste your .clr file text here as a String (or load from disk in-editor)
@export_multiline var clr_text := ""

@export var output_path := "res://Skin Maker/New Color Maker/Skins/New Color ressources/"
@export var output_display_name := "Aurora"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	return
	if not Engine.is_editor_hint():
		return
	if clr_text.strip_edges() == "":
		return

	var dict := _parse_clr_dictionary(clr_text)
	if dict.is_empty():
		push_error("Could not parse .clr text")
		return

	var res := PaletteResource.new()
	res.display_name = output_display_name
	res.dyes = []

  # Ensure Dye1..Dye28 order
	for i in range(28):
		var key := "Dye%d" % (i + 1)
		if not dict.has(key):
			push_error("Missing key: %s" % key)
			return
		res.dyes.append(dict[key])

	var err := ResourceSaver.save(res, output_path+output_display_name+".tres")
	if err != OK:
		push_error("Save failed: %s" % err)
	else:
		print("Saved palette:", output_path+output_display_name+".tres")

# Parses your exact format:
# { "Dye1": Color(80, 40, 120, 255), ... }
func _parse_clr_dictionary(text: String) -> Dictionary:
	var result := {}

  # Remove braces
	var t := text.strip_edges()
	if t.begins_with("{"):
		t = t.substr(1)
	if t.ends_with("}"):
		t = t.substr(0, t.length() - 1)

  # Split lines by comma, tolerate newlines/spaces
	var parts := t.split(",\n", false)
	if parts.size() == 1:
		parts = t.split(",", false)

	for p in parts:
		var line := p.strip_edges()
		if line == "":
			continue

	# Expect: "DyeX": Color(r, g, b, a)
		var colon := line.find(":")
		if colon == -1:
			continue

		var key := line.substr(0, colon).strip_edges().strip_edges()
		key = key.strip_edges()
		key = key.replace("\"", "")

		var rhs := line.substr(colon + 1).strip_edges()

	# Extract numbers inside Color(...)
		var start := rhs.find("Color(")
		if start == -1:
			continue
		start += "Color(".length()
		var end := rhs.find(")", start)
		if end == -1:
			continue

		var inside := rhs.substr(start, end - start)
		var nums := inside.split(",", false)
		if nums.size() != 4:
			continue

		var r := float(nums[0].strip_edges())
		var g := float(nums[1].strip_edges())
		var b := float(nums[2].strip_edges())
		var a := float(nums[3].strip_edges())

	# Convert 0-255 -> 0-1
		result[key] = Color(r / 255.0, g / 255.0, b / 255.0, a / 255.0)

	return result
