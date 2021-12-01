// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define PATTERN_SCALE 80.0
#define BACKGROUND vec3(0.850, 0.752, 0.505)

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float horizontal_pattern(vec2 st, float start, float width, float pattern_tone) {
    float vertical = mix(
    	0.0,
        pattern_tone,
        step(start / PATTERN_SCALE, st.y) * (1.0 - step((start + width) / PATTERN_SCALE, st.y))
    );
    
    return vertical;
}

float vertical_pattern(vec2 st, float start, float width, float pattern_tone) {
    float horizontan = mix(
    	0.0,
        pattern_tone,
        step((start / PATTERN_SCALE), st.x) * (1.0 - step((start + width) / PATTERN_SCALE, st.x))
    );
    return horizontan;
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    
    vec2 st_pattern = fract(st * PATTERN_SCALE);
    float pattern_tone = step(0.5, st_pattern.x);
    pattern_tone = pattern_tone == step(0.5, st_pattern.y) ? 1.0 : .0;
    pattern_tone = mix(
    	0.0,
        0.40,
        pattern_tone
    );
    
    vec2 st_canvas = fract(st * 3.0);
    
	float vertical = vertical_pattern(st_canvas, 8.0, 4.0, pattern_tone);
    vertical += vertical_pattern(st_canvas, 66.0, 4.0, pattern_tone);
    
    float horizontal = horizontal_pattern(st_canvas, 8.0, 4.0, pattern_tone);
    horizontal += horizontal_pattern(st_canvas, 66.0, 4.0, pattern_tone);
    
    float middle = vertical_pattern(st_canvas, 30.0, 20.0, pattern_tone);
    middle += horizontal_pattern(st_canvas, 30.0, 20.0, pattern_tone);
    
    
    float tone = horizontal + vertical + middle;
    
    vec3 horizontal_stripes = mix(
    	vec3(0.0),
        vec3(0.050, 0.772, 0.196),
        horizontal
    );
    
    vec3 vertical_stripes = mix(
    	vec3(0.0),
        vec3(0.050, 0.772, 0.196),
        vertical
    );
    
    vec3 middle_stripes = mix(
    	vec3(0.0),
        vec3(0.819, 0.070, 0.019),
        middle
    );
    
    vec3 color = horizontal_stripes + vertical_stripes + middle_stripes;
    
    
    gl_FragColor = vec4(vec3(color), 1.0);
}