extends Node

@onready var import_dialog: FileDialog = $ImportDialog

func _on_import_pressed() -> void:
	import_dialog.popup_centered()

func _on_import_selected(path: String) -> void:
	# Load the selected .tres
	var res := ResourceLoader.load(path)
	if not (res is PaletteResource):
		_set_status_error("Error:\nNot a PaletteResource .tres")
		return

	# Save a copy into your app's user:// palette folder so your Reader can find it
	var dir_path := "user://Skin Maker/New Color Maker/Skins/"
	DirAccess.make_dir_recursive_absolute(dir_path)

	var ColorName := (res as PaletteResource).display_name
	if ColorName.strip_edges() == "":
		ColorName = "Imported"
	
	var base_name := ColorName.strip_edges()
	if base_name == "":
		base_name = "Imported"
	
	var dest_path := dir_path + base_name + ".tres"
	var n := 1
	while FileAccess.file_exists(dest_path):
		ColorName = "%s (%d)" % [base_name, n]
		dest_path = dir_path + ColorName + ".tres"
		n += 1

	var err := ResourceSaver.save(res, dest_path)
	if err != OK:
		_set_status_error("Error:\nImport save failed (" + str(err) + ")")
		return

	_set_status_ok("Imported: " + ColorName)
	get_parent().get_node("Editor/Reader/Reader").reset(ColorName)

func _set_status_error(msg: String) -> void:
	var status := get_node("Status")
	status.clear()
	status.push_color(Color8(250, 40, 40))
	status.add_text(msg)

func _set_status_ok(msg: String) -> void:
	var status := get_node("Status")
	status.clear()
	status.push_color(Color8(25, 250, 80))
	status.add_text(msg)
