extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func updatecolorhelper(DyeName,PickerList):
	var ShaderMat = get_parent().get_parent().get_parent().get_node("Camera2D/Liam/Animation").material
	ShaderMat.set_shader_parameter(DyeName,get_node(PickerList).color * 255)

func updateall():
	updatecolorhelper("Dye1","0")
	updatecolorhelper("Dye2","1")
	updatecolorhelper("Dye3","2")
	updatecolorhelper("Dye4","3")
	updatecolorhelper("Dye5","4")
	updatecolorhelper("Dye6","5")
	updatecolorhelper("Dye7","6")
	updatecolorhelper("Dye8","7")
	updatecolorhelper("Dye9","8")
	updatecolorhelper("Dye10","9")
	updatecolorhelper("Dye11","10")
	updatecolorhelper("Dye12","11")
	updatecolorhelper("Dye13","12")
	updatecolorhelper("Dye14","13")
	updatecolorhelper("Dye15","14")
	updatecolorhelper("Dye16","15")
	updatecolorhelper("Dye17","16")
	updatecolorhelper("Dye18","17")
	updatecolorhelper("Dye19","18")
	updatecolorhelper("Dye20","19")
	updatecolorhelper("Dye21","20")
	updatecolorhelper("Dye22","21")
	updatecolorhelper("Dye23","22")
	updatecolorhelper("Dye24","23")
	updatecolorhelper("Dye25","24")
	updatecolorhelper("Dye26","25")
	updatecolorhelper("Dye27","26")
	updatecolorhelper("Dye28","27")
	

func _on__color_changed0(color: Color) -> void:
	updatecolorhelper("Dye1","0")
	
func _on__color_changed1(color: Color) -> void:
	updatecolorhelper("Dye2","1")

func _on__color_changed2(color: Color) -> void:
	updatecolorhelper("Dye3","2")

func _on__color_changed3(color: Color) -> void:
	updatecolorhelper("Dye4","3")

func _on__color_changed4(color: Color) -> void:
	updatecolorhelper("Dye5","4")

func _on__color_changed5(color: Color) -> void:
	updatecolorhelper("Dye6","5")

func _on__color_changed6(color: Color) -> void:
	updatecolorhelper("Dye7","6")

func _on__color_changed7(color: Color) -> void:
	updatecolorhelper("Dye8","7")

func _on__color_changed8(color: Color) -> void:
	updatecolorhelper("Dye9","8")

func _on__color_changed9(color: Color) -> void:
	updatecolorhelper("Dye10","9")

func _on__color_changed10(color: Color) -> void:
	updatecolorhelper("Dye11","10")

func _on__color_changed11(color: Color) -> void:
	updatecolorhelper("Dye12","11")

func _on__color_changed12(color: Color) -> void:
	updatecolorhelper("Dye13","12")

func _on__color_changed13(color: Color) -> void:
	updatecolorhelper("Dye14","13")

func _on__color_changed14(color: Color) -> void:
	updatecolorhelper("Dye15","14")

func _on__color_changed15(color: Color) -> void:
	updatecolorhelper("Dye16","15")

func _on__color_changed16(color: Color) -> void:
	updatecolorhelper("Dye17","16")

func _on__color_changed17(color: Color) -> void:
	updatecolorhelper("Dye18","17")

func _on__color_changed18(color: Color) -> void:
	updatecolorhelper("Dye19","18")

func _on__color_changed19(color: Color) -> void:
	updatecolorhelper("Dye20","19")
	
func _on__color_changed20(color: Color) -> void:
	updatecolorhelper("Dye21","20")

func _on__color_changed21(color: Color) -> void:
	updatecolorhelper("Dye22","21")

func _on__color_changed22(color: Color) -> void:
	updatecolorhelper("Dye23","22")

func _on__color_changed23(color: Color) -> void:
	updatecolorhelper("Dye24","23")

func _on__color_changed24(color: Color) -> void:
	updatecolorhelper("Dye25","24")

func _on__color_changed25(color: Color) -> void:
	updatecolorhelper("Dye26","25")

func _on__color_changed26(color: Color) -> void:
	updatecolorhelper("Dye27","26")

func _on__color_changed27(color: Color) -> void:
	updatecolorhelper("Dye28","27")
