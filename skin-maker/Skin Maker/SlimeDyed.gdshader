shader_type canvas_item;

render_mode blend_mix;

uniform int borderthickness = 1;
uniform vec4 bordercolor = vec4(1,0,0,1);

uniform vec4 Dye1 = vec4(0,0,0,255);
uniform vec4 Dye2 = vec4(0,0,0,255);
uniform vec4 Dye3 = vec4(0,0,0,255);
uniform vec4 Dye4 = vec4(0,0,0,255);
uniform vec4 Dye5 = vec4(0,0,0,255);
uniform vec4 Dye6 = vec4(0,0,0,255);
uniform vec4 Dye7 = vec4(0,0,0,255);
uniform vec4 Dye8 = vec4(0,0,0,255);
uniform vec4 Dye9 = vec4(0,0,0,255);
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

//Cape color
const vec4 Base1 = vec4(062,046,074,255);
const vec4 Base2 = vec4(111,049,152,255);
const vec4 Base3 = vec4(098,067,120,255);
const vec4 Base4 = vec4(145,102,176,255);
const vec4 Base5 = vec4(181,165,213,255);
const vec4 Base6 = vec4(198,186,222,255);
//gloves
const vec4 Base7 = vec4(012,015,046,255);
const vec4 Base8 = vec4(033,038,105,255);
const vec4 Base9 = vec4(083,088,153,255);
const vec4 Base10= vec4(134,138,181,255);
//boots
const vec4 Base11= vec4(051,022,010,255);
const vec4 Base12= vec4(089,038,017,255);
//eyes
const vec4 Base13= vec4(099,136,016,255);
const vec4 Base14= vec4(149,204,025,255);
const vec4 Base15= vec4(227,227,227,255);
//magic
const vec4 Base16= vec4(000,038,255,255);
const vec4 Base17= vec4(000,255,255,255);
//belt
const vec4 Base18= vec4(255,000,000,255);
const vec4 Base19= vec4(255,255,255,255);
//tunic
const vec4 Base20= vec4(069,099,135,255);
const vec4 Base21= vec4(092,132,184,255);
const vec4 Base22= vec4(149,174,204,255);
//border
const vec4 Base23= vec4(000,000,000,255);
//staff
const vec4 Base24= vec4(121,069,046,255);
const vec4 Base25= vec4(166,110,086,255);
const vec4 Base26= vec4(170,132,116,255);
const vec4 Base27= vec4(196,170,141,255);
const vec4 Base28= vec4(228,213,167,255);
//end

const vec4 floatConv = vec4(255,255,255,255);

uniform vec4 colorShift;
void vertex() {
	// Called for every vertex the material is visible on.
}



void fragment() {
	vec4 Texture = texture(TEXTURE,UV) * floatConv;
	vec3 tex_rgb = Texture.rgb;






	vec4 BaseColorArray[28] = vec4[28](Base1,Base2,Base3,Base4,Base5,Base6,Base7,
	Base8,Base9,Base10,Base11,Base12,Base13,Base14,Base15,Base16,Base17,Base18,
	Base19,Base20,Base21,Base22,Base23,Base24,Base25,Base26,Base27,Base28);

	vec4 DyeColorArray[28] = vec4[28](Dye1, Dye2, Dye3, Dye4, Dye5, Dye6, Dye7, Dye8, Dye9,
Dye10, Dye11, Dye12, Dye13, Dye14, Dye15, Dye16, Dye17, Dye18, Dye19, Dye20, Dye21, Dye22,
Dye23, Dye24, Dye25, Dye26, Dye27, Dye28);

	vec4 used_color = Texture/floatConv;
	for(int i = 0; i < 28; i++){
		if(tex_rgb == BaseColorArray[i].rgb){
			used_color = DyeColorArray[i]/floatConv;
			break;
		}
	}
	COLOR.rgb = used_color.rgb;
	//COLOR.a = Texture.a;

	//OUTLINE TEST
for(int x = -borderthickness; x <= borderthickness; x++)
	for(int y = -borderthickness; y <= borderthickness; y++){
		if(Texture.a == 0.f){
			vec4 bordertex = texture(TEXTURE,UV + vec2(float(x),float(y))*TEXTURE_PIXEL_SIZE);
			if(bordertex.a != 0.f){
				COLOR = bordercolor;
			}
		}

	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
