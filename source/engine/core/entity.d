module engine.core.entity;

import engine.core.interfaces.i_entity;
import engine.core.interfaces.i_mesh;

import gl3n.linalg;

class Entity : IEntity
{
private:
    mat4 model;
    IMesh mesh;

public:

    this(IMesh mesh)
    {
        this.model = mat4.identity;
        this.mesh = mesh;
    }

    void transform(mat4 t)
    {
        model *= t;
    }

    override mat4 getModel()
    {
        return model;
    }

    override IMesh getMesh()
    {
        return mesh;
    }

}
