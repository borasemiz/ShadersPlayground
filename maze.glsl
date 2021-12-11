// Author: Bora Semiz
// Title: Maze

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 st() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    
    return st;
}

float random(vec2 st) {
    return fract(
        sin(
        	dot(st.xy, vec2(12.9898, 78.233))
        ) * 43758.5453123
    );
}

float truchetPattern(vec2 st, float index) {
    if (index > 0.5) {
        return abs(st.y - st.x);
    } else {
        return abs(st.y + st.x - 1.0);
    }
}

void main() {
    vec2 st = st();
    
    vec2 ipos = floor(st * 10.0);
    vec2 fpos = fract(st * 10.0);
    
    float tone = -smoothstep(
        0.0,
        0.17,
        truchetPattern(fpos, random(ipos))
    ) + 1.0;
	
    vec3 color = vec3(
        tone
    );

    gl_FragColor = vec4(color,1.0);
}