:: ====================================================================
::  Name:     spawnShell.bat
:: 
:: Purpose:
::    This script wraps docker exec to spawn another shell in a running container.
:: 
::  Arguments:
::     - Container name
:: 
::  Returns:
::     Places user in new interactive shell inside running container.
::
::  Author(s):  Tejas Roysam     (Initial version)
:: 
::  History:  Date Written  2020-03-30
:: ====================================================================
@echo off

: Check usage
if "%~1"=="--help" goto usage
if "%~1"=="-h" goto usage
if "%~1"=="" goto usage
goto :script

:: Display usage
:usage
    echo "This script will start a new interactive session inside a running container. (Windows)" 
	echo. & echo "Usage: .\spawnShell.bat <CONTAINER NAME>"
	echo "e.g.:  .\spawnShell.bat march-20-workspace"
    echo "NOTE: If your <CONTAINER_NAME> is not found, a list of all containers will be displayed."
exit /B 1

:: Execute script
:script

set CONTAINER_NAME=%1

:: Find container hash
for /f "tokens=*" %%a in ('docker ps -aqf "name=%CONTAINER_NAME%"') do set CONT_FOUND=%%a

if "%CONT_FOUND%"=="" goto nocont
goto finish

:: No container found
:nocont
echo "No container named %CONTAINER_NAME% found. See full list of containers below:"
docker ps -a
exit /B 1

:: Finish executing script
:finish

echo "------ Spawning bash shell inside %CONTAINER_NAME%... ------"

docker exec -it %CONTAINER_NAME% /bin/bash
