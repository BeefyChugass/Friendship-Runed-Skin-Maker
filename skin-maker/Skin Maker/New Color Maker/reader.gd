extends Node

const PALETTES: Array[PaletteResource] = [
	preload("res://Skin Maker/New Color Maker/Skins/Aurora.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Bloody.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Dummy.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Empty.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Liam.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Love.tres"),
	preload("res://Skin Maker/New Color Maker/Skins/Red.tres"),
]

var user_palettes: Array[PaletteResource] = [] # ADDED
var all_palettes: Array[PaletteResource] = []  # ADDED

var load_index: int = 0
var selected_name: String = "Aurora"
var first_ready := false

@onready var color_list: ItemList = $ColorList
@onready var color_count: RichTextLabel = $ColorCount

func _ready() -> void:
	_load_user_palettes() # ADDED
	all_palettes = PALETTES + user_palettes # ADDED

	_populate_palette_list()

	color_count.clear()
	color_count.add_text("Colors Loaded: %d" % all_palettes.size()) # CHANGED

	if not first_ready:
		var idx := _find_palette_index_by_name(selected_name)
		if idx != -1:
			load_index = idx
		load_color(load_index)
		first_ready = true

func reset(color_name: String) -> void:
	selected_name = color_name
	first_ready = false
	_ready()

func _populate_palette_list() -> void:
	color_list.clear()

	for i in range(all_palettes.size()): # CHANGED
		var p := all_palettes[i]         # CHANGED
		var name := p.display_name if p.display_name != "" else "Palette %d" % i
		color_list.add_item(name, null, true)

func _find_palette_index_by_name(name: String) -> int:
	for i in range(all_palettes.size()): # CHANGED
		var p := all_palettes[i]          # CHANGED
		if p.display_name == name:
			return i
	return -1

func load_color(id: int) -> void:
	if id < 0 or id >= all_palettes.size(): # CHANGED
		return

	var palette := all_palettes[id] # CHANGED
	if palette == null:
		return

	var pickers := get_parent().get_parent().get_node("Color Pickers/ColorPickers")

	for i in range(28):
		if i >= palette.dyes.size():
			break
		pickers.get_child(i).color = palette.dyes[i]

	pickers.updateall()
	get_parent().get_parent().get_parent().get_node("Export").current_palette = palette

	var status := get_parent().get_parent().get_node("Builder/Builder/Status")
	status.clear()
	status.push_color(Color8(20, 250, 40))

	var shown_name := color_list.get_item_text(id)
	status.add_text("%s Loaded" % shown_name)

func _load_user_palettes() -> void: # ADDED
	user_palettes.clear()

	var dir_path := "user://Skin Maker/New Color Maker/Skins/"
	DirAccess.make_dir_recursive_absolute(dir_path)

	var d := DirAccess.open(dir_path)
	if d == null:
		return

	d.list_dir_begin()
	var fn := d.get_next()
	while fn != "":
		if not d.current_is_dir() and fn.to_lower().ends_with(".tres"):
			var pth := dir_path + fn
			var res := load(pth)
			if res is PaletteResource:
				user_palettes.append(res)
		fn = d.get_next()
