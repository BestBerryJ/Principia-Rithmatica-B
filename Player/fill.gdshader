shader_type canvas_item;
uniform float fill_length;
uniform sampler2D tex;

void fragment() {
	float alpha = UV.x > fill_length ? 0.5 : 1.0;
	vec2 sample = vec2(fract(UV.x), UV.y);
	COLOR = vec4(texture(tex, sample).xyz, alpha);
}