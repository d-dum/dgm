module engine.core.shader_program;

import engine.core.interfaces.i_program;
import engine.core.interfaces.i_shader;

import bindbc.opengl;

import gl3n.linalg;

class ShaderProgram : IProgram
{
private:
    GLuint id;
    bool active = false;

public:
    override GLuint getId()
    {
        return id;
    }

    override void start()
    {
        active = true;
        glUseProgram(id);
    }

    override void stop()
    {
        active = false;
        glUseProgram(0);
    }

    override bool isActive()
    {
        return active;
    }

    this(IShader[] shaders)
    {
        id = glCreateProgram();
        foreach(shader; shaders)
        {
            glAttachShader(id, shader.getId());
        }
        glLinkProgram(id);
    }

    override void loadMatrix(const(char*) location, mat4 m)
    {
        GLuint loc = glGetUniformLocation(id, location);
        glUniformMatrix4fv(loc, 1, GL_TRUE, m.value_ptr);
    }

}
