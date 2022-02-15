#include "GL/glew.h"
#include "GLFW/glfw3.h"

#include <iostream>

void ErrorCallback (int code, const char *message) {
	std::cout << "Error: " << message << '\n';
}

// TEMPORARY
int main () {
	glfwSetErrorCallback(ErrorCallback);

	if (!glfwInit())
		return -1;

	GLFWwindow *window;
	window = glfwCreateWindow(640, 480, "game", NULL, NULL);
	if (!window)
	{
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	GLenum error = glewInit();
	if (error != GLEW_OK) {
		std::cout << "ERROR: " << glewGetErrorString(error) << '\n';
		return -1;
	}

	while (!glfwWindowShouldClose(window)) {
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glfwTerminate();
	return 0;
}