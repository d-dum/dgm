module engine.core.interfaces.i_mesh;

import bindbc.opengl;

interface IMesh
{
    abstract GLuint getVAO() @nogc;
    abstract GLuint getVBO() @nogc;
    abstract GLuint getEBO() @nogc;
    abstract uint getVertexCount() @nogc;

    final void cleanUp()
    {
        GLuint[] buf = [this.getVBO(), this.getEBO()];
        GLuint buf1 = this.getVBO();
        glDeleteBuffers(1, &buf1);
        buf1 = this.getEBO();
        glDeleteBuffers(1, &buf1);
        ///GLuint[] v = [this.getVAO()];
        //glDeleteVertexArrays(1, v.ptr);
    }
}
