shader_type spatial;
void vertex() {
	VERTEX.y +=sin(TIME *5.0 + VERTEX.x);
}
void fragment() {
	vec3 color;
	color.r =1.0;
	color.g =5.0;
	color.b =0.0;
	ALBEDO=color;
	ROUGHNESS=1.0;
	METALLIC=cos(TIME*5.0)+1.0;
}