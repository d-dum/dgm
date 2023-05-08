#version 330 core

layout(location = 0) in vec3 vrt;

uniform mat4 Proj;
uniform mat4 View;
uniform mat4 Model;

void main()
{
    gl_Position = Proj * View * Model * vec4(vrt, 1.0);
}
