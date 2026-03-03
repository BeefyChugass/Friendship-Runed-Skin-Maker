extends Node

signal pasted_text_ready(text: String) # ADDED

var _paste_poll_timer: Timer # ADDED

func _ready() -> void: # ADDED
	# Poller for the web overlay result
	_paste_poll_timer = Timer.new()
	_paste_poll_timer.wait_time = 0.2
	_paste_poll_timer.one_shot = false
	_paste_poll_timer.autostart = false
	add_child(_paste_poll_timer)
	_paste_poll_timer.timeout.connect(_poll_paste_overlay_result)

	pasted_text_ready.connect(_on_pasted_text_ready)

func import_from_paste_tres() -> void:
	# Web: use overlay instead of Godot TextEdit paste (itch-safe)
	if OS.has_feature("web"): # ADDED
		start_paste_overlay()   # ADDED
		_paste_poll_timer.start() # ADDED
		return # ADDED
	else:
		if $PasteBox.visible == false:
			$PasteBox.visible = true
			return

	# Desktop/editor: keep your original behavior
	var txt: String = $PasteBox.text
	_import_from_text(txt) # ADDED (tiny refactor)

func _on_pasted_text_ready(text: String) -> void: # ADDED
	_paste_poll_timer.stop()
	_import_from_text(text)

func _import_from_text(txt: String) -> void: # ADDED
	var res := _parse_palette_resource_from_tres_text(txt)
	if res == null:
		_set_status_error("Error:\nCould not parse pasted .tres text")
		return

	# Save to user:// so your Reader can find it
	var dir_path := "user://Skin Maker/New Color Maker/Skins/"
	DirAccess.make_dir_recursive_absolute(dir_path)

	# Auto-rename if exists: Name.tres, Name (1).tres, ...
	var ColorName := res.display_name.strip_edges()
	if ColorName == "":
		ColorName = "Imported"
	res.display_name = ColorName

	var base_name := ColorName
	var path := dir_path + base_name + ".tres"
	var n := 1
	while FileAccess.file_exists(path):
		ColorName = "%s (%d)" % [base_name, n]
		path = dir_path + ColorName + ".tres"
		n += 1
	res.display_name = ColorName

	var err := ResourceSaver.save(res, path)
	if err != OK:
		_set_status_error("Error:\nSave failed (" + str(err) + ")")
		return

	_set_status_ok("Imported: " + ColorName)
	get_parent().get_node("Editor/Reader/Reader").reset(ColorName)

func _parse_palette_resource_from_tres_text(txt: String) -> PaletteResource:
	# 1) display_name = "Sus"
	var display_name := ""
	var dn := RegEx.new()
	dn.compile('display_name\\s*=\\s*"([^"]*)"')
	var dn_match := dn.search(txt)
	if dn_match:
		display_name = dn_match.get_string(1)

	# 2) extract Color(r,g,b,a) entries from dyes line
	# works even if the line is huge / wrapped
	var re := RegEx.new()
	re.compile('Color\\(\\s*([-0-9.]+)\\s*,\\s*([-0-9.]+)\\s*,\\s*([-0-9.]+)\\s*,\\s*([-0-9.]+)\\s*\\)')
	var matches := re.search_all(txt)
	if matches.size() < 28:
		return null

	var res := PaletteResource.new()
	res.display_name = display_name
	res.dyes = []

	# The pasted .tres includes lots of Color(...) (including possibly others),
	# but in your example it's exactly the dyes list. We’ll just take the first 28.
	for i in range(28):
		var m = matches[i]
		var r := float(m.get_string(1))
		var g := float(m.get_string(2))
		var b := float(m.get_string(3))
		var a := float(m.get_string(4))
		res.dyes.append(Color(r, g, b, a))

	return res

func _set_status_error(msg: String) -> void:
	var status := get_node("Status")
	status.clear()
	status.push_color(Color8(250,40,40))
	status.add_text(msg)

func _set_status_ok(msg: String) -> void:
	var status := get_node("Status")
	status.clear()
	status.push_color(Color8(25,250,80))
	status.add_text(msg)

# -------------------------
# Web overlay paste catcher
# -------------------------

func start_paste_overlay() -> void: # ADDED
	if not OS.has_feature("web"):
		return

	JavaScriptBridge.eval("""
(() => {
  const old = document.getElementById('godotPasteOverlay');
  if (old) old.remove();

  const wrap = document.createElement('div');
  wrap.id = 'godotPasteOverlay';
  wrap.style.position = 'fixed';
  wrap.style.left = '0';
  wrap.style.top = '0';
  wrap.style.width = '100%';
  wrap.style.height = '100%';
  wrap.style.background = 'rgba(0,0,0,0.65)';
  wrap.style.zIndex = '999999';
  wrap.style.display = 'flex';
  wrap.style.alignItems = 'center';
  wrap.style.justifyContent = 'center';

  const box = document.createElement('div');
  box.style.width = 'min(900px, 92vw)';
  box.style.height = 'min(520px, 75vh)';
  box.style.background = '#111';
  box.style.border = '1px solid #444';
  box.style.borderRadius = '12px';
  box.style.padding = '12px';
  box.style.display = 'flex';
  box.style.flexDirection = 'column';
  box.style.gap = '8px';

  const title = document.createElement('div');
  title.textContent = 'Paste your PaletteResource .tres text here, then click Import';
  title.style.color = '#fff';
  title.style.fontFamily = 'sans-serif';
  title.style.fontSize = '14px';

  const ta = document.createElement('textarea');
  ta.id = 'godotPasteTextarea';
  ta.style.flex = '1';
  ta.style.width = '100%';
  ta.style.resize = 'none';
  ta.style.background = '#000';
  ta.style.color = '#fff';
  ta.style.border = '1px solid #333';
  ta.style.borderRadius = '8px';
  ta.style.padding = '10px';
  ta.style.fontFamily = 'monospace';
  ta.style.fontSize = '12px';

  const row = document.createElement('div');
  row.style.display = 'flex';
  row.style.gap = '8px';
  row.style.justifyContent = 'flex-end';

  const cancel = document.createElement('button');
  cancel.textContent = 'Cancel';
  cancel.style.padding = '8px 12px';

  const ok = document.createElement('button');
  ok.textContent = 'Import';
  ok.style.padding = '8px 12px';

  cancel.onclick = () => wrap.remove();
  ok.onclick = () => {
    window.__godot_pasted_text = ta.value || '';
    wrap.remove();
  };

  row.appendChild(cancel);
  row.appendChild(ok);
  box.appendChild(title);
  box.appendChild(ta);
  box.appendChild(row);
  wrap.appendChild(box);
  document.body.appendChild(wrap);

  setTimeout(() => ta.focus(), 50);
})();
""")

func _poll_paste_overlay_result() -> void: # ADDED
	if not OS.has_feature("web"):
		return

	var txt = JavaScriptBridge.eval("window.__godot_pasted_text || '';", true)
	if typeof(txt) == TYPE_STRING and String(txt) != "":
		JavaScriptBridge.eval("window.__godot_pasted_text = '';", false)
		emit_signal("pasted_text_ready", String(txt))
