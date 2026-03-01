extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var ColorCount = 0;
	var Directory = DirAccess.open("res://scenes/player_select/player_shader/colors/")
	Directory.list_dir_begin()
	var ColorFileName = Directory.get_next()
	while ColorFileName != "":
		if(ColorFileName != "1Colors.txt"):
			get_node("ColorList").add_item(ColorFileName,null,true)
			ColorCount += 1
		ColorFileName = Directory.get_next()
	get_node("ColorCount").add_text("Colors Loaded: " + str(ColorCount))
	pass

func reset():
	get_node("ColorList").clear()
	get_node("ColorCount").clear()
	_ready()


func loadColor(id):
	var path = "res://scenes/player_select/player_shader/colors/" + get_node("ColorList").get_item_text(id)
	if(FileAccess.file_exists(path)):
		var ColorFile = FileAccess.open(path,FileAccess.READ)
		var ColorString = ColorFile.get_as_text()
		var ColorList = str_to_var(ColorString)
		
		var nodePath = get_parent().get_node("ColorPickers")
		for i in 28:
			var rgba = ColorList["Dye"+str(1+i)]
			nodePath.get_child(i).color = Color(rgba[0]/255,rgba[1]/255,rgba[2]/255,rgba[3]/255)
			print(nodePath.get_child(i).color)
	get_parent().get_node("ColorPickers").updateall()
	get_parent().get_node("Builder").get_node("Status").clear()
	get_parent().get_node("Builder").get_node("Status").push_color(Color8(20,250,40))
	
	
	
	get_parent().get_node("Builder").get_node("Status").add_text(str(get_node("ColorList").get_item_text(id)) + " Loaded")

	pass
#func updatecolorpickers():
#	var amount = 35
#	var sibling_node = get_parent().get_node("ColorPickers")
#	for i in 35:
#		var color_picker = sibling_node.get_child(i)
#		if color_picker:
#			color_picker_color = 
