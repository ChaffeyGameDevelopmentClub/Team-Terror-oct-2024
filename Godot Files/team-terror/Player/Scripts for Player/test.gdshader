shader_type spatial;

uniform float outerRadius : hint_range(0.0, 5.0) = 1.0;
uniform float MainAlpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	float x = abs(UV.x-.5)*2.0;
	float y = abs(UV.y-.5)*2.0;

}