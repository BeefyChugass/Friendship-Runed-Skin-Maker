extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func createColor():
	var ColorName = get_child(0).text

	var dir_path := "user://Skin Maker/New Color Maker/Skins/"
	DirAccess.make_dir_recursive_absolute(dir_path)

	var path = dir_path + ColorName + ".tres"

	#var new_node = contr
	if(FileAccess.file_exists(path) == true): #check if file already exists
		get_node("Status").clear()
		get_node("Status").push_color(Color8(250,40,40))
		get_node("Status").add_text("Error:\nFile Exists already")
	else:
		# Build a PaletteResource and save it as a .tres into user://
		var nodepath = get_parent().get_parent().get_node("Color Pickers/ColorPickers")

		var res := PaletteResource.new()
		res.display_name = ColorName
		res.dyes = []

		for i in 28:
			res.dyes.append(nodepath.get_child(i).color)

		var err := ResourceSaver.save(res, path)
		if err != OK:
			get_node("Status").clear()
			get_node("Status").push_color(Color8(250,40,40))
			get_node("Status").add_text("Error:\nSave failed (" + str(err) + ")")
			return

		get_node("Status").clear()
		get_node("Status").push_color(Color8(25,250,80))
		get_node("Status").add_text("Color Saved")

		# IMPORTANT: Reader matches by display_name, not filename
		get_parent().get_parent().get_node("Reader/Reader").reset(ColorName)
		pass
