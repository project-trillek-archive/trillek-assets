// VERTEX shader
#version 330

layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 norm;
layout(location = 2) in vec4 color;
layout(location = 3) in vec2 tex1;
layout(location = 4) in ivec4 boneIndex;
layout(location = 5) in vec4 boneWeight;

uniform vec3 light_pos;
uniform mat4 light_vp;
uniform mat4 light_ivp;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;
uniform mat4 animation_matrix[33];
uniform int animated;

out vec4 ex_pos;

const float PI = 3.14159265;
const float TAU = 6.283185307;

void main(void)
{
    vec4 m_pos = vec4(pos, 1.0);
    vec4 animated_pos = m_pos;
    if (animated == 1) {
        float finalWeight = 1.0 - ( boneWeight.x + boneWeight.y + boneWeight.z );
        animated_pos  = (animation_matrix[boneIndex.x] * m_pos) * boneWeight.x;
        animated_pos += (animation_matrix[boneIndex.y] * m_pos) * boneWeight.y;
        animated_pos += (animation_matrix[boneIndex.z] * m_pos) * boneWeight.z;
        animated_pos += (animation_matrix[boneIndex.w] * m_pos) * finalWeight;
    }

    vec4 v_pos, lv_pos;
    v_pos = (model * vec4(animated_pos.xyz, 1.0));
    lv_pos = ( light_vp * v_pos );
    v_pos = projection * (view * v_pos);

    ex_pos = vec4(v_pos.zw, lv_pos.zw);

    gl_Position = lv_pos;
}
