// fragment shader
#version 330

in vec4 ex_pos;

out float out_depth;

void main(void)
{
    out_depth = ex_pos.z / ex_pos.w;
    gl_FragDepth = out_depth;
}
