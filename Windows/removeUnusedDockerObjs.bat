:: ====================================================================
::  Name:     removeUnusedDockerObjs.bat
:: 
:: Purpose:
::    This script wraps calls to docker rm and docker rmi to cleanup the docker working area
:: 
::  Arguments:
::     None
:: 
::  Returns:
::     Deletes unused Docker image layers and containers, and returns hashes of deleted objects.
::
::  Author(s):  Tejas Roysam     (Initial version)
:: 
::  History:  Date Written  2020-03-30
:: ====================================================================
@echo off

: Check usage
if "%~1"=="--help" goto usage
if "%~1"=="-h" goto usage
goto :script

:: Display usage
:usage
    echo "This script will remove all exited containers and dangling images. (Windows)" 
	echo "Usage: .\removeUnusedDockerObjs.bat"
    echo "NOTE: Ensure all containers you wish to keep are running interactively."
    echo "NOTE: This operation will not affect named (tagged) images." 
exit /B 1


:: Execute script
:script

echo "------ Removing containers not attached to shells, and image layers not related to tagged images. ------"

docker rm -v $(docker ps --filter status=exited -q 2>NUL) 2>NUL
docker rmi $(docker images --filter dangling=true -q 2>NUL) 2>NUL