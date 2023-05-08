module engine;

public
{
    import engine.core.display_manager;
    import engine.core.interfaces.i_mesh;
    import engine.core.mesh;
    import engine.core.renderer;
    import engine.core.interfaces.i_shader;
    import engine.core.interfaces.i_program;
    import engine.core.shader;
    import engine.core.shader_program;
    import engine.core.interfaces.i_camera;
    import engine.core.interfaces.i_entity;
    import engine.core.camera;
    import engine.core.entity;
}

import bindbc.opengl;

public
{
    const GLenum VERTEX_SHADER = GL_VERTEX_SHADER;
    const GLenum FRAGMENT_SHADER = GL_FRAGMENT_SHADER;
}
