extends Camera2D

var spam: bool = false
var steps
var current_screen = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_RIGHT) and spam == false and current_screen != 2:
		move_to_test_scene()
		
	elif Input.is_key_pressed(KEY_LEFT) and spam == false and current_screen != 1:
		move_to_color_pickers()

func move_to_test_scene():
		get_node("ToTesterButon").visible = false
		get_node("ToColorsButton").visible = true
		get_node("ToColorsButton2").visible = false
		get_node("ToExportButon").visible = false
		current_screen=2
		spam = true
		var tween = self.create_tween()
		tween.tween_property(self,"position",Vector2(960, 180),0.5)
		await tween.finished
		spam = false

func move_to_color_pickers():
		get_node("ToTesterButon").visible = true
		get_node("ToColorsButton").visible = false
		get_node("ToColorsButton2").visible = false
		get_node("ToExportButon").visible = true
		current_screen=1
		spam = true
		var tween = self.create_tween()
		tween.tween_property(self,"position",Vector2(320, 180),0.5)
		await tween.finished
		spam = false

func move_to_export():
		get_node("ToTesterButon").visible = false
		get_node("ToColorsButton").visible = false
		get_node("ToColorsButton2").visible = true
		get_node("ToExportButon").visible = false
		current_screen=1
		spam = true
		var tween = self.create_tween()
		tween.tween_property(self,"position",Vector2(-320, 180),0.5)
		await tween.finished
		spam = false


func _on_to_tester_buton_pressed() -> void:
	move_to_test_scene()


func _on_to_colors_button_pressed() -> void:
	move_to_color_pickers()


func _on_to_export_buton_pressed() -> void:
	move_to_export()
