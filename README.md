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