// post process fragment shader
#version 330

in vec2 ex_tex;

out vec4 out_level;

uniform vec4 pixels;

uniform sampler2D layer0;
uniform sampler2D layer1;
uniform sampler2D layer2;

void main(void) {
    vec4 lt_color = texture(layer0, ex_tex); // lit color
    vec4 rc_color = texture(layer1, ex_tex); // plain color / alpha
    vec4 rc_c1 = texture(layer1, ex_tex + vec2(pixels.z * -0.5, 0.0));
    vec4 rc_c2 = texture(layer1, ex_tex + vec2(pixels.z * 0.5, 0.0));
    vec3 glow = (rc_color.xyz + vec3(0.05)) * rc_color.www;
    glow += .25 * rc_c1.xyz * rc_c1.www;
    glow += .25 * rc_c2.xyz * rc_c2.www;
    out_level = vec4(glow + lt_color.xyz, 1.0);
}
