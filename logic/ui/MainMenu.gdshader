shader_type canvas_item;
uniform sampler2D zombyTexture: repeat_enable;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV*10. + vec2(TIME*-.5, 0);
	vec4 zmb = texture(zombyTexture, uv);
	//COLOR = vec4(1, 1, 1, .3)-zmb;
	vec3 cl = vec3(.31, .41, .21);
	COLOR = vec4((vec3(1)-zmb.rgb)*cl,zmb.a);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
