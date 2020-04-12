:: ====================================================================
::  Name:     configureDockerContainer.bat
:: 
:: Purpose:
::    This script will walk through configuring a docker image for development on a Windows PC.
:: 
::  Arguments:
::     - Relative path to a valid Dockerfile
:: 
::  Returns:
::     Builds and names an image from the provided Dockerfile
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
echo "This script will walk you through configuring a docker image that you can use for development. (Windows)" 
	echo. & echo "Usage: .\configureDockerContainer.bat <Path-to-Dockerfile>"
	echo. & echo "e.g.: .\configureDockerContainer.bat ../os_images/ubuntu/Dockerfile"
    echo. & echo "The image will be initally named according to your username and the date. Rename it with ./saveContainerAs." 
exit /B 1

:: Execute script
:script

set DOCK_PATH=%1

if exist DOCK_PATH 
(
	for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
     set unused=%%i
     set month=%%j
     set day=%%k
     set year=%%l
	)
	set DATESTR=%month%_%day%_%year%

	set IMG_NAME=%USERNAME%-dev-%DATESTR%

	echo "Building image %IMG_NAME% -----------------------------------"
	cd /d %DOCK_PATH%
	docker build -t $IMG_NAME .

	echo. & echo. & echo "------ Created development image: %IMG_NAME% ------"

	exit /B 0

) 
else 
(
	exit /B 1
)

