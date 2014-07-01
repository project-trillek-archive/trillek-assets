// fragment shader
#version 330

uniform sampler2D layer0;
uniform sampler2D layer1;
uniform sampler2D layer2;

uniform mat4x4 inv_proj;

uniform vec3 light_pos;
uniform vec3 light_dir;
uniform vec3 light_color;

uniform float radius;

in vec2 ex_tex;

out vec4 out_level;

void main(void)
{
    vec4 sc_color, sc_norm;
    vec4 f_world_pos;
    float w_depth;

    sc_color = texture(layer0, ex_tex); // color
    sc_norm = texture(layer1, ex_tex); // normals
    w_depth = texture(layer2, ex_tex).r; // depth buffer

    sc_norm = vec4(sc_norm.xyz * 2.0 - 1.0, sc_norm.w * 100.0);

    if(texture(layer1, ex_tex).xyz == vec3(0.5)) {
        discard; // this does not seem to catch anything, should be empty space
    }
    f_world_pos = inv_proj * vec4(ex_tex * 2.0 - 1.0, w_depth, 1.0);
    f_world_pos /= f_world_pos.w;

    vec3 light_vec = light_pos - f_world_pos.xyz;
    vec3 view_vec = normalize(-f_world_pos.xyz);

    float l_d = length(light_vec);
    float atten = 1.0 - dot(light_vec, light_vec) / (radius * radius);
    light_vec = normalize(light_vec);

    float norm_dot = -dot(sc_norm.xyz, -light_vec);
    float view_dot = dot(sc_norm.xyz, view_vec);
    if(view_dot < 0.0) {
        // if we are viewing the "backside", flip the normals and compute that way
        //discard;
        norm_dot = -dot(-sc_norm.xyz, -light_vec);
        view_dot = dot(-sc_norm.xyz, view_vec);
    }
    if(norm_dot < 0.0) {
        // light is facing away from this surface
        discard;
    }
    float l_diffuse = max(norm_dot, 0.0);

    float l_specular = 0.0;

    vec3 refs_vec = reflect(-light_vec, sc_norm.xyz);
    vec3 refv_vec = reflect(view_vec, sc_norm.xyz);
    float ref_dot = pow(clamp(dot(refs_vec, view_vec), 0.0, 1.0), sc_norm.w) * 0.2;

    //vec3 half_vec = normalize(light_vec + view_vec);
    //float half_dot = dot(sc_norm.xyz, half_vec);
    //l_specular = pow(clamp(half_dot, 0.0, 1.0), sc_norm.w) * 0.2;

    vec3 light_level = sc_color.xyz * vec3(clamp(l_diffuse, 0.0, 1.0)) + vec3(ref_dot);
    out_level = clamp(vec4(light_color * light_level * atten, 1.0), 0.0, 1.0);
}
