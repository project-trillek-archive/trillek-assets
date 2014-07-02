// fragment shader
#version 330

in vec4 ex_color;
in vec3 ex_nvect;
in vec3 ex_cvect;
in vec2 ex_tex1;

out vec4 end_result;

uniform sampler2D texUnit;

void main(void)
{
    vec4 tci;

    tci = texture(texUnit, ex_tex1);
    if(tci == vec4(0)) {
        discard;
    }
    if(tci.w != 0) {
        tci *= vec4(dot(ex_cvect,ex_nvect));
    }

    end_result = tci;
}
