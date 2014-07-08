// fragment shader
#version 330

in vec4 ex_color;
in vec3 ex_nvect;
in vec3 ex_cvect;
in vec2 ex_tex1;
in vec4 ex_pos;

uniform sampler2D layer0;

out vec4 out_col;

void main(void)
{
    out_col = vec4(ex_pos.x * 0.25 + 0.5,0.1, ex_pos.z / ex_pos.w, 0);
    gl_FragDepth = ex_pos.z / ex_pos.w;
}
