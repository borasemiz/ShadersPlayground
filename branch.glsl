// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float stroke(float x, float s, float w) {
    float d = step(s, x + w * .5) - step(s, x - w * .5);
    return clamp(d, 0.0, 1.0);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	
    float offset = st.y - 0.1;
    float start_of_whole_thing = 0.0;
    vec3 color = vec3(
    	stroke(st.x, start_of_whole_thing + .28 + offset, .1)
    );

    gl_FragColor = vec4(color, 1.0);
}