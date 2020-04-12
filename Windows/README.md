# Windows Workflow:

See the top-level README for an overview of scripts and usage. Below are Windows-specific setup and usage instructions.

### Prerequisites (first time setup):

#### Software:
- Download and install Docker/Docker desktop: https://www.docker.com/products/docker-desktop
- Download and install Git (64-bit): https://git-scm.com/downloads
- Install Moba XTerm Portable Home edition: https://mobaxterm.mobatek.net/download.html 

#### Activate Virtualization
Check if virtualization is enabled in the Windows task manager's performance tab  

If virtualization is not enabled  
   - Restart your computer  
   - Hit F10 (or F1, F2, etc - varies from machine-to-machine) to enter BIOS settings  
   - Find Security -> System Security  
   - Enable Virtualization  
   - Save and Exit  
   - Retart computer

#### Repo:
1. Clone repo locally (using powershell): 

  `git clone https://github.com/roysamt/DnD.gitt`

3. Allocate resources: In the docker advanced settings (accessed from the Windows taskbar), allocate at least half of your CPUs and memory to Docker (ideally).

4. Linux Container Mode: From the Docker Desktop menu, select *Switch to Linux containers* to use Linux containers (if not already selected).

5. Open Moba XTerm's settings, and in the **settings** tab, set **X11 remote access** to **FULL**

#### Restart:
Restart your Windows machine, then complete setup by logging in to docker:

1. Login to your local docker registry.

  `docker login localhost:8080`

##### Notes

- **Fonts**: Some text editors may not initialize monospace fonts correctly. I will document fixes for specific editors as run into them below:
    - *Sublime Text 3*: When you first open sublime in your container, add the following line to your **User Settings** if you have alignment/font issues, then restart Sublime: `"font_face": "DejaVu Sans Mono",`

#### Workflow example:

In the following example, John Doe is performing the following tasks:
- Setting up the base image repo
- Configuring and generating his development image 
- Creating and starting a new docker container to work in, using his development image
  - In this new container, he has all the functionality of a root user in a Linux bash shell
- John then exits the container shell, back to his Mac terminal
- He saves his changes to the environment as a *new* image, separate from his development image
  - This is useful to do if you have changed the environment in some way, and want to keep your development image clean.
- Once saved, he resumes working in the same container by restarting it
- Exiting once more, he cleans up his docker workspace


```bash
[john-doe-powershell~$] git clone https://github.com/roysamt/DnD.git

[john-doe-powershell~$] docker login localhost:8080

[john-doe-powershell~$] ipconfig
...
Ethernet Adapter X:
...
IPv4 Address: 152.001.111.222
...

[john-doe-powershell~$] vi startDockerContainer.bat
...
<John edits Line 41 to read: 
for /f "tokens=14" %%a in ('ipconfig ^| findstr IPv4 ^| findstr 152.') do set HOST_IP=%%a
because his IP above starts with 152>
...

[john-doe-powershell~$] cd DnD/docker-dev/Windows

[john-doe-powershell~$] configureDockerContainer.bat os_images/centos7/Dockerfile
...
...
Created development image: jdoe1-dev-20200401

[john-doe-powershell~$] startDockerContainer.bat mytest jdoe1-dev-20200401
...
... 
[root@18d2a6f2379f #] echo "I am now a root user inside a docker container shell."
I am now a root user inside a docker container shell.

[root@18d2a6f2379f #] exit
exit

[john-doe-powershell~$] saveContainerAs.bat mytest jdoe1-dev-20200401-COPY
sha256:a7e79ce8322ff570231f2b512448ae152b15b6f0274d94656c7f3706b65ed127
mytest

  Saved image jdoe1-dev-20200401-COPY and stopped container mytest.
  
[john-doe-powershell~$] restartContainer.bat mytest
...
...
[root@18d2a6f2379f #] echo "I am back in the same \(restarted\) container."
I am back in the same (restarted) container.

[root@18d2a6f2379f #] exit
exit

[john-doe-powershell~$] removeUnusedDockerObjs.bat 
Removing containers not attached to shells, and image layers not related to tagged images.
...
...
Deleted: sha256:9e771b0dde4b3ffb3bb07c73029d91ad6616d1bc3b47a22eb800292918fb6030

[john-doe-powershell~$] 
```
