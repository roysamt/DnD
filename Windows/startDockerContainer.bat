:: ====================================================================
::  Name:     startDockerContainer.bat
:: 
:: Purpose:
::    This script will run a docker container for development on a Windows PC.
:: 
::  Arguments:
::     - Container name
::     - Image name
:: 
::  Returns:
::     Creates and configures a new container for X11 display forwarding, and places the user
::     in an interactive shell within it.
::
::  Author(s):  Tejas Roysam     (Initial version)
:: 
::  History:  Date Written  2020-03-30
:: ====================================================================
@echo off

:: Check usage
if "%~1"=="--help" goto usage
if "%~1"=="-h" goto usage
if "%~1"=="" goto usage
if "%~2"=="" goto usage
goto :script

:: Display usage
:usage
echo "This script will launch a NEW docker container with your chosen name, using the image you specify. (Windows)" 
	echo. & echo "Usage: .\startDockerContainer.bat <CONTAINER NAME> <IMAGE NAME>"
	echo. & echo "e.g.: .\startDockerContainer.bat mycontainer roysamt-dev-20200401"
    echo. & echo "To find your Docker image name, use ^"docker images^". The container name is up to you." 
exit /B 1

:: Execute script
:script

set CONTAINER_NAME=%1
set IMAGE_NAME=%2

:: Determine IP for display
for /f "tokens=14" %%a in ('ipconfig ^| findstr IPv4 ^| findstr 192.') do set HOST_IP=%%a
set DISPLAY=%HOST_IP%:0.0

echo "You will now be placed inside the docker container..."

echo ""
echo "#################################################################"
echo "IMPORTANT:"
echo "If you are unable to bring up displays (browsers, text editors, etc.), you must EDIT this file as per the README"
echo "Run the following command in powershell, and find the OUTWARD facing IP:"
echo "ipconfig"
echo "Change line 41 to correspond to the first 3 digits of your network IP"
echo "Then re-run this script."
echo "#################################################################"
echo ""

docker run --name %CONTAINER_NAME% -it --privileged -e DISPLAY=%DISPLAY% %IMAGE_NAME%

echo ""
echo "#################################################################"
echo "If this script outputs:"
echo "You have to remove (or rename) that container to be able to reuse that name"
echo "You already have a running container with that name! Use ./restartContainer to jump back in, or remove it with:"
echo "docker stop <name>"
echo "docker rm <name>"
echo "Then re-run this script."
echo "#################################################################"
echo ""