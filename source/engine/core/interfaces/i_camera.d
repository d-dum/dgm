module engine.core.interfaces.i_camera;

import gl3n.linalg;

interface ICamera
{
    abstract mat4 getView();
}
