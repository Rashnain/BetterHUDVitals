shader_type canvas_item;

uniform float value;

void fragment() {
	if (COLOR.w > 0.5) {
		if (UV.y <= 1.0 - value) {
			COLOR.w = 0.4;
		} else {
			COLOR.w = 0.8;
		}
	}
}
