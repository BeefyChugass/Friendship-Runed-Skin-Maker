extends Node

@onready var animation = get_parent().get_node("Camera2D/Liam/Animation")
var animation_array
var weather = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("Idle")
	animation_array = animation.sprite_frames.get_animation_names()
	for anim in animation_array:
		get_node("AnimationList").add_item(anim, null, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_list_item_activated(index: int) -> void:
	animation.play(animation_array[index])
	var plattform = get_node("Sprite2D/plattform")
	if animation_array[index] == "Jump":
		var tween = self.create_tween()
		tween.tween_property(plattform, "position:y",200,0.2)
	else:
		var tween = self.create_tween()
		tween.tween_property(plattform, "position:y",96, 0.1)
	pass # Replace with function body.


func _on_animation_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	_on_animation_list_item_activated(index)


func _on_weather_toggle_pressed() -> void:
	var sprite = get_node("Sprite2D/Morning")
	match weather:
		0:
			var tween = self.create_tween()
			tween.tween_property(sprite,"self_modulate:a",1.0,0.5)
			await tween.finished
			weather = 1
		1:
			var tween = self.create_tween()
			tween.tween_property(sprite,"self_modulate:a",0.0,0.5)
			await tween.finished
			weather = 0
