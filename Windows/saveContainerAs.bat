:: ====================================================================
::  Name:     saveContainerAs.bat
:: 
:: Purpose:
::    This script wraps docker commit to save a container as a new image.
:: 
::  Arguments:
::     - Container name
::     - Desired image save name
:: 
::  Returns:
::     Creates new image with provided name from given container.
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
	echo "This script will commit a container to a new image (Windows)" 
	echo "Usage: .\saveContainerAs.bat <CONTAINER NAME> <IMAGE SAVENAME>"
	echo. & echo "e.g.:  .\saveContainerAs.bat march-20-workspace newimagecopy"
    echo. & echo "NOTE: If your <IMAGE SAVENAME> is an existing image, it will be overwritten."
    echo "If you want to keep your changes separate from the image you are using now, change <IMAGE SAVENAME>" 
exit /B 1

:: Execute script
:script

set CONTAINER_NAME=%1
set IMAGE_SAVENAME=%2

:: Find container hash
for /f "tokens=*" %%a in ('docker ps -aqf "name=%CONTAINER_NAME%"') do set CONT_HASH=%%a

if "%CONT_HASH%"=="" goto nocont
goto finish

:: No container found
:nocont
echo "No container named %CONTAINER_NAME% found. See full list of containers below:"
docker ps -a
exit /B 1

:: Finish executing script
:finish
docker commit %CONT_HASH% %IMAGE_SAVENAME%

docker stop %CONTAINER_NAME%

echo "#################################################################"
echo "Note: This container is stopped but not removed. To remove it, run:"
echo> & echo "docker rm %CONTAINER_NAME%"
echo "#################################################################"

exit /B 0