module engine.core.interfaces.i_entity;

import engine.core.interfaces.i_mesh;

import gl3n.linalg;

interface IEntity
{
    abstract mat4 getModel();
    abstract IMesh getMesh();
}
