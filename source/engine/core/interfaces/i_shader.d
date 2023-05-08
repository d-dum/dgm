module engine.core.interfaces.i_shader;

import bindbc.opengl;

interface IShader
{
    abstract GLuint getId();
    abstract GLenum getType();

    final void cleanUp()
    {
        glDeleteShader(this.getId());
    }
}
