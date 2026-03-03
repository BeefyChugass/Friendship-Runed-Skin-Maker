extends ColorPickerButton

func _on_pressed():
	# Access the PopupPanel
	var popup = get_popup()
	
	# Option A: Move to a specific screen position (Global Coordinates)
	popup.position = Vector2i(100, 100)
	
	# Option B: Position relative to the button (e.g., to the right)
	# Wait one frame for the popup to initialize its size
	await get_tree().process_frame 
	popup.position = Vector2(500,0)
	get_parent().get_parent().get_parent().get_node("Reader/Reader/ColorList").visible = false
	get_parent().get_parent().get_parent().get_node("Reader/Reader/ColorCount").visible = false
	


func _on_popup_closed() -> void:
	get_parent().get_parent().get_parent().get_node("Reader/Reader/ColorList").visible = true
	get_parent().get_parent().get_parent().get_node("Reader/Reader/ColorCount").visible = true
	
