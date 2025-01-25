{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libGL
    glfw
    glew
    jdk17
    mesa
    mesa-demos
  ];
}
