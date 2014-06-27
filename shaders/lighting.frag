// fragment shader
#version 330

uniform sampler2D layer0;
uniform sampler2D layer1;
uniform sampler2D layer2;

in vec2 ex_tex;

out vec4 out_level;

void main(void)
{
    vec4 sc_color, ofs_color;
    float depth;
    float w_depth;

    sc_color = texture(layer0, ex_tex);
    //ofs_color = texture(layer1, ex_tex); // normals
    //w_depth = texture(layer2, ex_tex).r;
    //depth = (2.0 * 0.1 * 10000.0) / (10000.1 - ((2.0 * w_depth - 1.0) * 9999.9));
    //sc_color = vec4(depth * 0.05);
    out_level = sc_color;
}
