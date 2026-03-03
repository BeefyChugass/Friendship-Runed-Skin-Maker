shader_type canvas_item;
render_mode blend_mix;

uniform int borderthickness = 1;
uniform vec4 bordercolor = vec4(1.0, 0.0, 0.0, 1.0);

// Dye colors are expected in 0..255 like your originals
uniform vec4 Dye1  = vec4(0,0,0,255);
uniform vec4 Dye2  = vec4(0,0,0,255);
uniform vec4 Dye3  = vec4(0,0,0,255);
uniform vec4 Dye4  = vec4(0,0,0,255);
uniform vec4 Dye5  = vec4(0,0,0,255);
uniform vec4 Dye6  = vec4(0,0,0,255);
uniform vec4 Dye7  = vec4(0,0,0,255);
uniform vec4 Dye8  = vec4(0,0,0,255);
uniform vec4 Dye9  = vec4(0,0,0,255);
uniform vec4 Dye10 = vec4(0,0,0,255);
uniform vec4 Dye11 = vec4(0,0,0,255);
uniform vec4 Dye12 = vec4(0,0,0,255);
uniform vec4 Dye13 = vec4(0,0,0,255);
uniform vec4 Dye14 = vec4(0,0,0,255);
uniform vec4 Dye15 = vec4(0,0,0,255);
uniform vec4 Dye16 = vec4(0,0,0,255);
uniform vec4 Dye17 = vec4(0,0,0,255);
uniform vec4 Dye18 = vec4(0,0,0,255);
uniform vec4 Dye19 = vec4(0,0,0,255);
uniform vec4 Dye20 = vec4(0,0,0,255);
uniform vec4 Dye21 = vec4(0,0,0,255);
uniform vec4 Dye22 = vec4(0,0,0,255);
uniform vec4 Dye23 = vec4(0,0,0,255);
uniform vec4 Dye24 = vec4(0,0,0,255);
uniform vec4 Dye25 = vec4(0,0,0,255);
uniform vec4 Dye26 = vec4(0,0,0,255);
uniform vec4 Dye27 = vec4(0,0,0,255);
uniform vec4 Dye28 = vec4(0,0,0,255);

// Base palette (0..255)
const vec3 Base1  = vec3(62,46,74);
const vec3 Base2  = vec3(111,49,152);
const vec3 Base3  = vec3(98,67,120);
const vec3 Base4  = vec3(145,102,176);
const vec3 Base5  = vec3(181,165,213);
const vec3 Base6  = vec3(198,186,222);
const vec3 Base7  = vec3(12,15,46);
const vec3 Base8  = vec3(33,38,105);
const vec3 Base9  = vec3(83,88,153);
const vec3 Base10 = vec3(134,138,181);
const vec3 Base11 = vec3(51,22,10);
const vec3 Base12 = vec3(89,38,17);
const vec3 Base13 = vec3(99,136,16);
const vec3 Base14 = vec3(149,204,25);
const vec3 Base15 = vec3(227,227,227);
const vec3 Base16 = vec3(0,38,255);
const vec3 Base17 = vec3(0,255,255);
const vec3 Base18 = vec3(255,0,0);
const vec3 Base19 = vec3(255,255,255);
const vec3 Base20 = vec3(69,99,135);
const vec3 Base21 = vec3(92,132,184);
const vec3 Base22 = vec3(149,174,204);
const vec3 Base23 = vec3(0,0,0);
const vec3 Base24 = vec3(121,69,46);
const vec3 Base25 = vec3(166,110,86);
const vec3 Base26 = vec3(170,132,116);
const vec3 Base27 = vec3(196,170,141);
const vec3 Base28 = vec3(228,213,167);

const float INV_255 = 1.0 / 255.0;

bool same255(vec3 a, vec3 b) {
	// a and b are in 0..255 space
	// using a tiny tolerance avoids precision differences on mobile
	return all(lessThan(abs(a - b), vec3(0.5)));
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec3 tex255 = floor(tex.rgb * 255.0 + 0.5);

	vec4 out_col = tex;

	if (tex.a > 0.0) {
		// Unrolled palette swap (mobile-safe)
		if      (same255(tex255, Base1))  out_col = vec4(Dye1.rgb * INV_255, tex.a);
		else if (same255(tex255, Base2))  out_col = vec4(Dye2.rgb * INV_255, tex.a);
		else if (same255(tex255, Base3))  out_col = vec4(Dye3.rgb * INV_255, tex.a);
		else if (same255(tex255, Base4))  out_col = vec4(Dye4.rgb * INV_255, tex.a);
		else if (same255(tex255, Base5))  out_col = vec4(Dye5.rgb * INV_255, tex.a);
		else if (same255(tex255, Base6))  out_col = vec4(Dye6.rgb * INV_255, tex.a);
		else if (same255(tex255, Base7))  out_col = vec4(Dye7.rgb * INV_255, tex.a);
		else if (same255(tex255, Base8))  out_col = vec4(Dye8.rgb * INV_255, tex.a);
		else if (same255(tex255, Base9))  out_col = vec4(Dye9.rgb * INV_255, tex.a);
		else if (same255(tex255, Base10)) out_col = vec4(Dye10.rgb * INV_255, tex.a);
		else if (same255(tex255, Base11)) out_col = vec4(Dye11.rgb * INV_255, tex.a);
		else if (same255(tex255, Base12)) out_col = vec4(Dye12.rgb * INV_255, tex.a);
		else if (same255(tex255, Base13)) out_col = vec4(Dye13.rgb * INV_255, tex.a);
		else if (same255(tex255, Base14)) out_col = vec4(Dye14.rgb * INV_255, tex.a);
		else if (same255(tex255, Base15)) out_col = vec4(Dye15.rgb * INV_255, tex.a);
		else if (same255(tex255, Base16)) out_col = vec4(Dye16.rgb * INV_255, tex.a);
		else if (same255(tex255, Base17)) out_col = vec4(Dye17.rgb * INV_255, tex.a);
		else if (same255(tex255, Base18)) out_col = vec4(Dye18.rgb * INV_255, tex.a);
		else if (same255(tex255, Base19)) out_col = vec4(Dye19.rgb * INV_255, tex.a);
		else if (same255(tex255, Base20)) out_col = vec4(Dye20.rgb * INV_255, tex.a);
		else if (same255(tex255, Base21)) out_col = vec4(Dye21.rgb * INV_255, tex.a);
		else if (same255(tex255, Base22)) out_col = vec4(Dye22.rgb * INV_255, tex.a);
		else if (same255(tex255, Base23)) out_col = vec4(Dye23.rgb * INV_255, tex.a);
		else if (same255(tex255, Base24)) out_col = vec4(Dye24.rgb * INV_255, tex.a);
		else if (same255(tex255, Base25)) out_col = vec4(Dye25.rgb * INV_255, tex.a);
		else if (same255(tex255, Base26)) out_col = vec4(Dye26.rgb * INV_255, tex.a);
		else if (same255(tex255, Base27)) out_col = vec4(Dye27.rgb * INV_255, tex.a);
		else if (same255(tex255, Base28)) out_col = vec4(Dye28.rgb * INV_255, tex.a);
	}

	// Outline (keep constant bounds for WebGL1 safety)
	const int MAX_THICKNESS = 1;

	if (tex.a == 0.0) {
		for (int x = -MAX_THICKNESS; x <= MAX_THICKNESS; x++) {
			for (int y = -MAX_THICKNESS; y <= MAX_THICKNESS; y++) {
				if (abs(x) <= borderthickness && abs(y) <= borderthickness) {
					vec4 n = texture(TEXTURE, UV + vec2(float(x), float(y)) * TEXTURE_PIXEL_SIZE);
					if (n.a != 0.0) {
						out_col = bordercolor;
					}
				}
			}
		}
	}

	COLOR = out_col;
}