// vertex shader to render the fullscreen quad
#version 330

in vec4 position;

out vec2 ex_tex;

void main(void) {
    ex_tex = position.zw;
    gl_Position = vec4(position.xy, 0.0, 1.0);
}
