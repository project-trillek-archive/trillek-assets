// vertex shader
#version 330
 
in vec3 pos;
in vec3 norm;
in vec4 color;
in vec2 tex1;
in ivec4 boneIndex;
in vec4 boneWeight;
 
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
uniform mat4 animation_matrix[33];
uniform int animated;
 
out vec4 ex_color;
out vec3 ex_nvect;
out vec3 ex_cvect;
out vec2 ex_tex1;
 
void main(void)
{
    vec4 animated_pos = vec4(pos, 1.0);
    vec4 pos_norm = vec4(norm + pos, 1.0);
    vec4 animated_norm = pos_norm;
    if (animated == 1) {
        animated_pos  = (animation_matrix[boneIndex.x] * vec4(pos, 1.0)) * boneWeight.x;
        animated_norm = (animation_matrix[boneIndex.x] * pos_norm) * boneWeight.x;
        animated_pos += (animation_matrix[boneIndex.y] * vec4(pos, 1.0)) * boneWeight.y;
        animated_norm+= (animation_matrix[boneIndex.y] * pos_norm) * boneWeight.y;
        animated_pos += (animation_matrix[boneIndex.z] * vec4(pos, 1.0)) * boneWeight.z;
        animated_norm+= (animation_matrix[boneIndex.z] * pos_norm) * boneWeight.z;

        float finalWeight = 1.0f - ( boneWeight.x + boneWeight.y + boneWeight.z );
        animated_pos += (animation_matrix[boneIndex.w] * vec4(pos, 1.0)) * finalWeight;
        animated_norm+= (animation_matrix[boneIndex.w] * pos_norm) * finalWeight;
    }

    vec4 v_pos;
    v_pos = view * (model * animated_pos);
    ex_cvect = normalize(vec3(0,0,0) - v_pos.xyz);
    ex_nvect = normalize((view * (model * animated_norm) - v_pos)).xyz;
 
    ex_color = color;
    ex_tex1 = tex1;
 
    gl_Position = projection * v_pos;
}
