// fragment shader
#version 130
 
in vec4 ex_color;
in vec3 ex_nvect;
in vec3 ex_cvect;
in vec2 ex_tex1;
 
out vec4 end_result;
 
void main(void)
{
        vec4 tci;
 
        tci = ex_color * vec2(dot(ex_cvect,ex_nvect),0.0).xxxx;
 
        end_result = vec4(tci.xyz,1.0);
}