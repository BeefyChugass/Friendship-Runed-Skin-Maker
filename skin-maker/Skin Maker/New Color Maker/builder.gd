extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func createColor():
	var ColorName = get_child(0).text
	var path = "res://Skin Maker/New Color Maker/Skins/" + ColorName + ".clr"
	if(FileAccess.file_exists(path) == true): #check if file already exists
		get_node("Status").clear()
		get_node("Status").push_color(Color8(250,40,40))
		get_node("Status").add_text("Error:\nFile Exists already")
	else:
		var ColorFile = FileAccess.open(path,FileAccess.WRITE) #readys file to write
		var nodepath = get_parent().get_parent().get_node("Color Pickers/ColorPickers")
		var Dyes = {}
		for i in 28:
			Dyes[i] = nodepath.get_child(i).color * 255
		
		var ColorSet = {"Dye1": Dyes[0],"Dye2": Dyes[1],"Dye3": Dyes[2],"Dye4": Dyes[3],"Dye5": Dyes[4],"Dye6": Dyes[5],"Dye7": Dyes[6],
		"Dye8": Dyes[7],"Dye9": Dyes[8],"Dye10": Dyes[9],"Dye11": Dyes[10],"Dye12": Dyes[11],"Dye13": Dyes[12],"Dye14": Dyes[13],
		"Dye15": Dyes[14], "Dye16": Dyes[15], "Dye17": Dyes[16], "Dye18": Dyes[17], "Dye19": Dyes[18], "Dye20": Dyes[19], "Dye21": Dyes[20], 
		"Dye22": Dyes[21], "Dye23": Dyes[22], "Dye24": Dyes[23], "Dye25": Dyes[24], "Dye26": Dyes[25], "Dye27": Dyes[26], "Dye28": Dyes[27], 
		}
		var ColorSetStr = var_to_str(ColorSet)
		ColorFile.store_string(ColorSetStr)
		get_node("Status").clear()
		get_node("Status").push_color(Color8(25,250,80))
		get_node("Status").add_text("Color Saved")
		get_parent().get_parent().get_node("Reader/Reader").reset(ColorName+".clr")
		pass
