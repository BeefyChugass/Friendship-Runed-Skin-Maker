extends Node

@onready var export_dialog: FileDialog = $ExportDialog

# you need a way to know which palette is currently selected
# (use your Reader's selection or store it when loading)
var current_palette: PaletteResource

func _on_export_pressed() -> void:
	if current_palette == null:
		_set_status_error("Error:\nNo palette selected")
		return

	if OS.has_feature("web"):
		_export_web_download(current_palette)
	else:
		export_dialog.popup_centered()

func _on_export_path_selected(path: String) -> void:
	if current_palette == null:
		_set_status_error("Error:\nNo palette selected")
		return

	var p := path
	if not p.to_lower().ends_with(".tres"):
		p += ".tres"

	var err := ResourceSaver.save(current_palette, p)
	if err != OK:
		_set_status_error("Error:\nExport failed (" + str(err) + ")")
		return

	_set_status_ok("Exported")

func _export_web_download(palette: PaletteResource) -> void:
	# Save to a temp file in user://, then download its bytes
	var tmp_dir := "user://tmp/"
	DirAccess.make_dir_recursive_absolute(tmp_dir)

	var filename := (palette.display_name if palette.display_name != "" else "Palette") + ".tres"
	var tmp_path := tmp_dir + filename

	var err := ResourceSaver.save(palette, tmp_path)
	if err != OK:
		_set_status_error("Error:\nExport failed (" + str(err) + ")")
		return

	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(tmp_path)
	JavaScriptBridge.download_buffer(bytes, filename, "application/octet-stream")

	_set_status_ok("Downloaded: " + filename)

func _set_status_error(msg: String) -> void:
	var status := get_parent().get_node("Import/Status")
	status.clear()
	status.push_color(Color8(250, 40, 40))
	status.add_text(msg)

func _set_status_ok(msg: String) -> void:
	var status := get_parent().get_node("Import/Status")
	status.clear()
	status.push_color(Color8(25, 250, 80))
	status.add_text(msg)
