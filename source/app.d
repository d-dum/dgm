import std.stdio;

import engine;

import std.file : readText;

import bindbc.opengl;
import gl3n.linalg;

void main()
{
	DisplayManager mng = new DisplayManager();

	string vt = readText("res/shaders/vert.glsl");
	string vb = readText("res/shaders/frag.glsl");

	IShader[] shaders = [
		new Shader(vt, GL_VERTEX_SHADER),
		new Shader(vb, GL_FRAGMENT_SHADER)
	];


	ShaderProgram program = new ShaderProgram(shaders);

	float[] vertices = [
		-0.5f, 0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
        0.5f, -0.5f, 0.0f,
        0.5f, 0.5f, 0.0f,
	];

	uint[] indices = [
		0, 1, 3,
		3, 1, 2
	];

	Mesh mesh = new Mesh(vertices, indices);
	Camera cam = new Camera(vec3(0.0f, 0.0f, 3.0f), vec3(0.0f, 0.0f, 0.0f), vec3(0.0f, 1.0f, 0.0f));
	Entity en = new Entity(mesh);

	Renderer renderer = new Renderer(mng);

	writeln(program.getId());

	while(!mng.isCloseRequested())
	{
		renderer.prepare();

		renderer.render(en, cam, program);

		mng.update();
	}

}
