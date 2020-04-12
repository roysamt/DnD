:: ====================================================================
::  Name:     plublishImage.sh
:: 
:: Purpose:
::    This script will push the specified image to the js-er-code server.
:: 
::  Arguments:
::     - Image name
:: 
::  Returns:
::     Tags and pushes image to local registry
::
::  Author(s):  Tejas Roysam     (Initial version)
:: 
::  History:  Date Written  2020-03-30
:: ====================================================================

d@echo off

: Check usage
if "%~1"=="--help" goto usage
if "%~1"=="-h" goto usage
if "%~1"=="" goto usage
goto :script

:: Display usage
:usage
    echo "This script will push a specified image to the local Docker registry. (Windows)" 
	echo. & echo "Usage: Usage: .\plublishImage.bat <IMAGE_NAME>"
	echo "Use this if you want to share your development image with others, or back it up."
    echo "NOTE: You must be logged in to docker to execute this script."
exit /B 1

:: Execute script
:script

set IMAGE_NAME_IN=%1
set IMAGE_NAME=localhost:8080/${IMAGE_NAME_IN}

docker tag $IMAGE_NAME_IN $IMAGE_NAME  

docker push %IMAGE_NAME%