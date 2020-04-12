# MacOS Setup and Usage:

See the top-level README for an overview of scripts and usage. Below are Mac-specific setup and usage instructions.

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

##### Notes

- **Fonts**: Some text editors may not initialize monospace fonts correctly. I will document fixes for specific editors as run into them below:
    - *Sublime Text 3*: When you first open sublime in your container, add the following line to your **User Settings** if you have alignment/font issues, then restart Sublime: `"font_face": "DejaVu Sans Mono",`
- **XQuartz**: Whenever XQuarts prompts you if you want to close it, select **YES**. We need to open and close the X11 server connection when performing a container setup.


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
