module engine.core.camera;

import engine.core.interfaces.i_camera;

import gl3n.linalg;

class Camera : ICamera
{
private:
    mat4 view;

public:

    this(vec3 eye, vec3 target, vec3 up)
    {
        this.view = Matrix!(float, 4, 4).look_at(eye, target, up);
    }

    override mat4 getView()
    {
        return view;
    }
}
