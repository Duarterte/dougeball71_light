shader_type spatial;
render_mode unshaded;
uniform sampler2D MapTextur: repeat_enable, filter_nearest_mipmap;
uniform vec3 playerPos;

void fragment() {
	ALBEDO = texture(MapTextur, UV+playerPos.xz).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
