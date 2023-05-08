module engine.core.interfaces.i_program;

import bindbc.opengl;

import gl3n.linalg;

interface IProgram
{
    abstract GLuint getId() @nogc;

    abstract void start() @nogc;

    abstract void stop() @nogc;

    abstract bool isActive() @nogc;

    abstract void loadMatrix(const(char*) location, mat4 m);

    final void cleanUp() @nogc
    {
        glDeleteProgram(this.getId());
    }
}
