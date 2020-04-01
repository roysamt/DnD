# MacOS Setup and Usage:

Working in Docker can be done using these scripts which encapsulate the docker calls required for most common activities. 

### Prerequisites (first time setup):

#### Software:
- Download and install Docker/Docker desktop: https://www.docker.com/products/docker-desktop
- Download and install Git: https://git-scm.com/downloads
- Install xQuartz: https://www.xquartz.org/

#### Repo:
1. Clone this repo : 

  `git clone https://github.com/roysamt/DnD.git`

2. Login to your local Docker registry

  `docker login localhost:8080`

3. Open XQuartz's preferences, and in the security tab, check the box labeled **Allow connections from network clients**

**Note:** Some text editors may not initialize monospace fonts correctly. I will document fixes for specific editors as run into them below:
- *Sublime Text 3*: When you first open sublime in your container, add the following line to your **User Settings** if you have alignment/font issues, then restart Sublime: `"font_face": "DejaVu Sans Mono",`


#### Terminology:
You don't really need to know how Docker works under the hood to develop inside Docker (although its worth knowing), but you do at least need to know the following terms:

**IMAGE:** 

A generated "recipe" of an operating system environment. This is large, several gigabytes, and contains all the kernel, drivers, files, and programs that make up the base operating system and user working area.


**CONTAINER:** 

An *instance* of an **IMAGE** that can be run and which can host interactive **SHELLS**.


**SHELL:** 

A user interface which allows you to input commands and interact with the filesystem. In Linux, the default shell is Bash.


**SERVER:** 

The term server, when used here, refers to your **local** Docker registry, unless you logged into an externally hosted registry in the steps above. When you **push** to the server you are basically **saving your image** to the server, where it can be shared with other developers or computers/backed up/etc.

### Usage (day-to-day):
Think of this as an "API" of scripts. 
These are to be used **from your Mac terminal** to create and manipulate Docker containers and images.

#### When to use what:
- ./configureDockerContainer 
    - use this **once** to create your base image. Only use it again if you want to re-generate an entirely clean development environment.
- ./startDockerContainer 
    - use this **at the start of each development session**, i.e. once a day. When you start developing for the day, create a new container from your saved image and start working in that.
- ./spawnShell
    - use this **frequently**, whenever you have a container running and want to get an extra shell inside it. Run this from another terminal tab/window. You can spawn as many shells as you desire for a given container.
- ./saveContainerAs 
    - use this **at the end of each development session**, i.e. once a day. When you are finished developing for the day, save the container you have been working in to an image. You will probably want to overwrite your previous image, but you can also make a copy if you want.
- ./restartContainer 
    - use this if you have **exit**ed your container, and want to jump back into it. This will likely not be used often, but is available if you ever **exit** a container and want to get back in soon afterward.
- ./removeUnusedDockerObjs  
    - use this **occasionally**. This is a "cleanup" script which frees up space. Over time, docker will eat up space with stopped containers and with "layers" of images it stores to make building images faster. You don't have to worry about this. Just run this script occasionally after saving.
- ./publishImage 
    - use this **only** if you want to push your image to your local or remote registry.
- exit
    - use this **inside** a docker container to leave, and get back to your Mac shell.
- **For all scripts, use the --help flag to get usage instructions and an example**

**Note: if a script results in XQuartz to ask you if you want to close it, select YES**


The table below describes each script, it's required arguments, and its function.

|**Script**|**Arg 1**|**Arg 2**|**Description**|
|---|---|---|---|
|./configureDockerContainer.sh|<PPATH-TO-DOCKERFILE>    |  |This configures and creates your base image, using the specified Dockerfile "recipe". It outputs the name of the image it creates to the command line.| 
|./startDockerContainer.sh    |<CONTAINER_NAME>|<IMAGE_NAME>    |This creates a new container with the specified name from the image created by `./configureDockerContainer`, and places you in an interactive shell inside the container.|
|./spawnShell.sh           |<CONTAINER_NAME>|                |Use this to spawn a new shell inside a running container.|
|./saveContainerAs.sh            |<CONTAINER_NAME>|<IMAGE_SAVENAME>|When you want to save your workspace after closing your container's shell, you can either save it on top of the image originally generated, or as a new image. If you want a new image, give it a new name, otherwise pass the same name.|
|./restartContainer.sh           |<CONTAINER_NAME>|                |Use this to restart a container already created by `./startDockerContainer.sh`.|
|./removeUnusedDockerObjs.sh     |                |                |Use this periodically to clear up disk space occupied by old containers and unused image layers.|
|./publishImage.sh|<IMAGE_NAME>||This will publish the selected image to the local registry.|


When you are inside a docker container, you can develop as you would on a native machine with the Dockerfile-specified OS environment. When you wish to exit the container, just type **exit**.


#### Workflow example:

In the following example, John Doe is performing the following tasks:
- Setting up the base image repo
- Configuring and generating his development image 
- Creating and starting a new docker container to work in, using his development image (a RHEL7 image in this case)
  - In this new container, he has all the functionality of a root user in a Linux bash shell
- John then exits the container shell, back to his Mac terminal
- He saves his changes to the environment as a *new* image, separate from his development image
  - This is useful to do if you have changed the environment in some way, and want to keep your development image clean.
- Once saved, he resumes working in the same container by restarting it
- Exiting once more, he cleans up his docker workspace

----

```bash
[john-doe-macbook~$] git clone https://github.com/roysamt/DnD.git

[john-doe-macbook~$] docker login localhost:8080

[john-doe-macbook~$] cd DnD/docker-dev/MacOS

[john-doe-macbook~$] ./configureDockerContainer.sh os_images/centos7/Dockerfile
...
...
Created development image: jdoe1-dev-20200401

[john-doe-macbook~$] ./startDockerContainer.sh mytest jdoe1-dev-20200401
...
... 
[root@18d2a6f2379f #] echo "I am now a root user inside a docker container shell."
I am now a root user inside a docker container shell.

[root@18d2a6f2379f #] exit
exit

[john-doe-macbook~$] ./saveContainerAs.sh mytest jdoe1-dev-20200401-COPY
sha256:a7e79ce8322ff570231f2b512448ae152b15b6f0274d94656c7f3706b65ed127
mytest

  Saved image jdoe1-dev-20200401-COPY and stopped container mytest.
  
[john-doe-macbook~$] ./restartContainer.sh mytest
...
...
[root@18d2a6f2379f #] echo "I am back in the same \(restarted\) container."
I am back in the same (restarted) container.

[root@18d2a6f2379f #] exit
exit

[john-doe-macbook~$] ./removeUnusedDockerObjs.sh 
Removing containers not attached to shells, and image layers not related to tagged images.
...
...
Deleted: sha256:9e771b0dde4b3ffb3bb07c73029d91ad6616d1bc3b47a22eb800292918fb6030

[john-doe-macbook~$] 
```
