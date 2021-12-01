// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	
    vec3 color = vec3(
    	step(.5 + cos(st.y * 3.0 * PI) * 0.05, st.x)
    );

    gl_FragColor = vec4(color, 1.0);
}