# Develop In Docker (DnD)

This is a simplified set of wrapper scripts that can be used to facilitate developing inside a Dockerized environment.

I use this to keep my working area clean, documented, replaceable, and consistent. 

This is useful because for any given project, I may want to work in a different Linux distro and/or may want different environment and package configurations.

There are a few "gotchas" and issues that I ran into while trying to standardize this environment setup, and I have addressed these for both Mac and Windows. 
The most prominent issue is X11 display forwarding from a Docker container to the host machine. 

Instructions for use provided per-platform. They're written to be readable to someone not at all familiar with Docker or Bash.

## Contents:

-  For **MacOS**, instructions for setup and general usage are provided in the `MacOS/` subdirectory.

-  For **Windows**, instructions for setup and general usage are provided in the `Windows/` subdirectory.

-  For **General Terminology and an API of scripts** see below.

-  **General TODOs** for me to add to provide more functionality while still abstracting away Docker knowledge.


## Terminology

| Term | Definition |
|---|---|
|**IMAGE**|A generated "recipe" of an operating system environment. This is large, several gigabytes, and contains all the kernel, drivers, files, and programs that make up the base operating system and user working area.|
|**CONTAINER**|An *instance* of an **IMAGE** that can be run and which can host interactive **SHELLS**.|
|**SHELL**|A user interface which allows you to input commands and interact with the filesystem. In Linux, the default and preffered shell is Bash. In Windows, the preferred shell is Powershell or Git Bash (not Windows command line (`cmd`)).|
|**SERVER**|The term server, when used here, refers to your **local** Docker registry, unless you logged into an externally hosted registry in the steps above. When you **push** to the server you are basically **saving your container** to the server, where it can be easily shared with other developers or computers, backed up, etc.|


## Scripts

Think of these as an "API" of scripts. Below is a table listing the parameters of each and suggested usage as part of a general workflow for developing inside a Dockerized environment.

These are to be used from your **Mac Terminal** or **Windows Powershell** to create and manipulate Docker containers and images.

**For all scripts, use the --help flag to get usage instructions and an example**

|**Script**|**Arg 1**|**Arg 2**|**Description**|
|---|---|---|---|
|configureDockerContainer|Path to Dockerfile||- This configures and creates your base image, using the specified Dockerfile "recipe". It outputs the name of the image it creates to the command line.<br>- Use this **once** to create your base image. Only use it again if you want to re-generate an entirely clean environment.| 
|startDockerContainer|CONTAINER NAME|IMAGE NAME|- Creates a new container with the specified name from the image created by `configureDockerContainer`, and places you in an interactive shell inside the container.<br>- Use this **at the start of each development session**, i.e. once a day. When you start developing for the day, create a new container from your saved image and start working in that.|
|spawnShell|CONTAINER NAME| |- Use this to spawn a new shell inside a running container. Run this as many times as you desire for a given container, using a new shell tab or window each time.<br>- Use this **frequently**, whenever you have a container running and want to get an extra shell inside it.|
|saveContainerAs|CONTAINER NAME|IMAGE SAVENAME|- When you want to save your workspace after closing your container's shell, you can either save it on top of the image originally generated, or as a new image. If you want a new image, give it a new name, otherwise pass the same name.<br>- Use this **at the end of each development session**, i.e. once a day. You will probably want to overwrite your previous image, but you can also make a copy if you want.|
|restartContainer|CONTAINER NAME| |- Use this to restart a container already created by `startDockerContainer`.<br>-Use this if you have **exit**ed your container, and want to jump back into it. This will likely not be used often, but is available if you ever **exit** a container and want to get back in soon afterward.|
|removeUnusedDockerObjs| | |- Clears up disk space occupied by old containers and unused image layers.<br>-Use this **occasionally** to free up space. Over time, docker will eat up space with stopped containers and with "layers" of images it stores to make building images faster. You don't have to worry about all that, just run this script occasionally after saving.|
|publishImage|IMAGE NAME| |- This will publish the selected image to the local registry.<br>- Use this **only** if you want to share your image or back it up. It pushes your image to the localhost:8000 Docker container registry.|

## General TODOs:

-  Add an abstracted script for copying files to/from Docker container.