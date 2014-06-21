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

    tci = texture(texUnit, ex_tex1) * vec4(dot(ex_cvect,ex_nvect));
    if(tci == 0) {
        discard;
    }

    end_result = vec4(tci.xyzw);
}
