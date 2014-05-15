// vertex shader
#version 330
 
in vec3 pos;
in vec3 norm;
in vec4 color;
in vec2 tex1;
 
uniform mat4 projection;
uniform mat4 view;
 
out vec4 ex_color;
out vec3 ex_nvect;
out vec3 ex_cvect;
out vec2 ex_tex1;
 
void main(void)
{
        vec4 v_pos;
 
        v_pos = view * vec4(pos, 1.0);
        ex_cvect = normalize(vec3(0,0,0)-v_pos.xyz);
        ex_nvect = normalize((view * vec4(norm+pos,1)) - v_pos).xyz;
 
        ex_color = color;
        ex_tex1 = tex1;
 
        gl_Position = projection * v_pos;
}