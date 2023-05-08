module engine.core.mesh;

import engine.core.interfaces.i_mesh;

import bindbc.opengl;

class Mesh : IMesh
{
private:

    GLuint vao, vbo, ebo;
    uint vertexCount;

public:
    override GLuint getVAO()
    {
        return vao;
    }

    override GLuint getVBO()
    {
        return vbo;
    }

    override GLuint getEBO()
    {
        return ebo;
    }

    override uint getVertexCount()
    {
        return vertexCount;
    }

    ~this()
    {
        //this.cleanUp();
    }

    this(float[] vertices, uint[] indices)
    {
        glGenVertexArrays(1, &vao);
        glBindVertexArray(vao);

        glGenBuffers(1, &vbo);
        glGenBuffers(1, &ebo);

        glBindBuffer(GL_ARRAY_BUFFER, vbo);
        glBufferData(GL_ARRAY_BUFFER, vertices.length * float.sizeof, vertices.ptr, GL_STATIC_DRAW);

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indices.length * uint.sizeof, indices.ptr, GL_STATIC_DRAW);

        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        glBindVertexArray(0);

        vertexCount = cast(uint) indices.length;
    }
}
