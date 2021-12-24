// Author: Bora Semiz
// Title: Four Circles

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define QUADRANT_COUNT 4.0
#define CIRCLES_RADIUS 0.08
#define RADIUS 0.75

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec2 st() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    
    return st;
}

void main() {
    vec2 st = st();
    float radius = 0.5;
    float values = atan(st.y, st.x) / (PI / 2.0) * QUADRANT_COUNT;
    
    float ipos = floor(values);
    float fpos = fract(values);
    
    float initial_angle = PI / (4.0 * QUADRANT_COUNT);
    float angle = initial_angle + (ipos * PI / (2.0 * QUADRANT_COUNT));
    float dist = distance(st, RADIUS * vec2(cos(angle), sin(angle)));
    
    vec3 color = vec3(
        smoothstep(
            CIRCLES_RADIUS,
            CIRCLES_RADIUS + 0.003,
            dist
        )
    );

    gl_FragColor = vec4(color,1.0);
}
