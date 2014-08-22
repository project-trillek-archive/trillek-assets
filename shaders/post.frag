// post process fragment shader
#version 330

in vec2 ex_tex;

out vec4 out_level;

uniform sampler2D layer0;

void main(void) {
    vec4 sc_color = texture(layer0, ex_tex); // color
    out_level = sc_color; // pass through color
}
