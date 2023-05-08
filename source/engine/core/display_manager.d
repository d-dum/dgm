module engine.core.display_manager;

import glfw3.api;
import bindbc.opengl;

import std.typecons : Tuple;

alias ScreenDimensions = Tuple!(int, "width", int, "height");
alias DisplayInfo = Tuple!(float, "delta", float, "last");

class DisplayManager
{
private:
    int width, height;
    GLFWwindow* window;
    DisplayInfo time;

    void updateTime()
    {
        const float current = glfwGetTime();
        time.delta = current - time.last;
        time.last = current;
    }

public:

    this(int width = 800, int height = 600, string windowName = "dgm")
    {
        this.width = width;
        this.height = height;

        if(!glfwInit())
            throw new Exception("Failed to initialize glfw");

        glfwWindowHint(GLFW_SAMPLES, 4); // 4x antialiasing
        glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
        glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
        glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE); // opengl core 3.3

        window = glfwCreateWindow(width, height, windowName.ptr, null, null);
        if(!window)
            throw new Exception("Failed to create window");

        glfwMakeContextCurrent(window);
        glfwSetInputMode(window, GLFW_STICKY_KEYS, GLFW_TRUE);

        const GLSupport retVal = loadOpenGL();
        if(retVal == GLSupport.badLibrary || retVal == GLSupport.noLibrary)
            throw new Exception("GL not found");

        if(retVal != GLSupport.gl33)
            throw new Exception("failed to load appropriate opengl version (3.3 core)");

        glViewport(0, 0, width, height);
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LESS);

        time.delta = 0;
        time.last = glfwGetTime();
    }

    ~this()
    {
        glfwDestroyWindow(window);
        glfwTerminate();
    }

    bool isCloseRequested()
    {
        return cast(bool) glfwWindowShouldClose(window);
    }

    void update()
    {
        updateTime();
        glfwGetFramebufferSize(window, &width, &height);
        glViewport(0, 0, width, height);
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    ScreenDimensions getDimensions()
    {
        ScreenDimensions ret;
        ret.width = width;
        ret.height = height;

        return ret;
    }

    DisplayInfo getInfo()
    {
        return time;
    }
}
