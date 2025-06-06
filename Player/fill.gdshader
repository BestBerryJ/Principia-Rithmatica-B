shader_type canvas_item;
uniform float fill_length;
uniform sampler2D tex;

varying vec2 f_pos;
varying vec2 f_tangent;
varying float f_damage; 

void vertex() {
	f_pos = VERTEX;
	f_tangent = COLOR.xy;
	f_damage = COLOR.z;
}

float random(vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) *
            43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    // Four corners in 2D of a tile
    float a = random(uv_index);
    float b = random(uv_index + vec2(1.0, 0.0));
    float c = random(uv_index + vec2(0.0, 1.0));
    float d = random(uv_index + vec2(1.0, 1.0));

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix(a, b, blur.x) +
            (c - a) * blur.y * (1.0 - blur.x) +
            (d - b) * blur.x * blur.y;
}

float fbm(vec2 uv) {
    int octaves = 6;
    float amplitude = 0.5;
    float frequency = 3.0;
	float value = 0.0;
	
    for(int i = 0; i < octaves; i++) {
        value += amplitude * noise(frequency * uv);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    return value;
}


void fragment() {
	float tex_strength = fbm(f_pos / 40.0);
	float feather = smoothstep(0.0, 1.0, 1.0 - 2.0 * (abs(UV.y - 0.5)));
	feather = feather < 0.2 ? 0.0 : feather;
	
	float fill = UV.x > fill_length ? 0.5 : 1.0;
	float alpha = tex_strength * feather * fill;
	
	COLOR = vec4(vec3(1.0), alpha);
	//COLOR = vec4(UV, 0.0, 1.0);
}