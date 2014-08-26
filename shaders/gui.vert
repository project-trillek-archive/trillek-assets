// VERTEX shader
#version 330

in vec4 in_pos;
in vec4 in_color;

uniform vec2 pxofs;
uniform vec2 pxscreen;

out vec4 ex_color;
out vec2 ex_tex1;

void main(void)
{
    ex_color = in_color;
    ex_tex1 = in_pos.zw;
    vec2 p_pos = ((in_pos.xy + pxofs) * pxscreen) * vec2(2.0, -2.0) + vec2(-1.0, 1.0);

    gl_Position = vec4(p_pos, 0.0, 1.0);
}
