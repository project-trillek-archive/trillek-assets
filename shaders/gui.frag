// fragment shader
#version 330

in vec4 ex_color;
in vec2 ex_tex1;

out vec4 out_color;

uniform sampler2D in_sampl;
uniform int on_tex1;

void main(void)
{
    vec4 tc;

    tc = texture(in_sampl, ex_tex1);
    if(on_tex1 == 0) {
        tc = ex_color;
    } else {
        tc *= ex_color;
    }
    if(tc.w == 0.0) {
        discard;
    }
    out_color = tc;
}
