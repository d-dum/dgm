module engine.core.shader;

import engine.core.interfaces.i_shader;

import bindbc.opengl;

import std.stdio;

class Shader : IShader
{
private:
    GLuint id;
    GLenum type;

    char[] toTerminatedChararr(string src)
    {
        char[] ret = [];

        foreach(i, c; src)
        {
            ret ~= c;
        }

        ret ~= '\0';
        return ret;
    }

public:

    override GLuint getId()
    {
        return id;
    }

    override GLenum getType()
    {
        return type;
    }

    this(string source, GLenum type)
    {
        const GLSupport retVal = loadOpenGL();
        this.type = type;
        id = glCreateShader(type);

        const GLint[1] sl = [cast(int) source.length];
        const(char)*[1] sources = [source.ptr];


        glShaderSource(id, 1, sources.ptr, sl.ptr);
        glCompileShader(id);


        int infoLogLength;
        GLint result = GL_FALSE;
        glGetShaderiv(id, GL_COMPILE_STATUS, &result);
        glGetShaderiv(id, GL_INFO_LOG_LENGTH, &infoLogLength);



        if(infoLogLength > 0)
        {
            import core.stdc.stdlib : malloc, free;

            char* log = cast(char*) malloc(char.sizeof * (infoLogLength + 1));



            scope(exit)
                free(log);

            glGetShaderInfoLog(id, infoLogLength, null, &log[0]);

            string lfg = "";
            foreach(i; 0..infoLogLength)
            {
                lfg ~= log[i];
            }

            throw new Exception(lfg);
        }
    }

    ~this()
    {
        this.cleanUp();
    }
}
