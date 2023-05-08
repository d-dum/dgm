module engine.core.renderer;

import engine.core.display_manager;
import engine.core.interfaces.i_mesh;
import engine.core.interfaces.i_entity;
import engine.core.interfaces.i_camera;
import engine.core.interfaces.i_program;

import gl3n.linalg;

import bindbc.opengl;

class Renderer
{
private:
    DisplayManager dm;
    mat4 projection;
    int width;
    int height;

    float fov;
    float near;
    float far;

    void updateProjection(ScreenDimensions dimensions)
    {
        this.projection = Matrix!(float, 4, 4).perspective(cast(float) dimensions.width, cast(float) dimensions.height, fov, near, far);
        this.width = dimensions.width;
        this.height = dimensions.height;
    }

public:

    this(DisplayManager dm, float fov = 45.0f, float near = 0.1f, float far = 100.0f)
    {
        this.dm = dm;
        ScreenDimensions dimensions = dm.getDimensions();
        this.fov = fov;
        this.near = near;
        this.far = far;
        this.updateProjection(dimensions);
    }

    void prepare()
    {
        ScreenDimensions dimensions = dm.getDimensions();
        if(dimensions.width != width || dimensions.height != height)
        {
            this.updateProjection(dimensions);
        }

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glClearColor(0, 0, 0, 1);
    }

    void render(IMesh mesh) @nogc
    {
        glBindVertexArray(mesh.getVAO());
        glEnableVertexAttribArray(0);

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, mesh.getEBO());
        glBindBuffer(GL_ARRAY_BUFFER, mesh.getVBO());

        glVertexAttribPointer(
            0,
            3,
            GL_FLOAT,
            GL_FALSE,
            0,
            null
            );

        glDrawElements(GL_TRIANGLES, mesh.getVertexCount(), GL_UNSIGNED_INT, null);

        glDisableVertexAttribArray(0);

        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        glBindVertexArray(0);
    }

    void render(IEntity entity, ICamera camera, IProgram program)
    {
        import std.stdio : writeln;
        bool deactivate = false;
        if(!program.isActive())
        {
            deactivate = true;
            program.start();
        }

        program.loadMatrix("Proj", projection);
        program.loadMatrix("View", camera.getView());
        program.loadMatrix("Model", entity.getModel());

        /* uint projLoc = glGetUniformLocation(program.getId(), "Proj");
        writeln("Proj ", projLoc); */

        render(entity.getMesh());

        if(deactivate)
            program.stop();
    }

}
