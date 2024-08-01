shader_type spatial;
render_mode unshaded;

void fragment() {
	ALBEDO = vec3(1., 0, 0);
	ALPHA = 0.3;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
