@rem Usage: run.bat {container name you like}
@echo off

@REM Edit the following variables as needed:
@REM PORT: Local port number to connect with novnc
@REM VOLUME: A directory on the host side where data inside the container is stored.
set PORT=6080
set VOLUME=%cd%/../robot_manipulation

echo *** Access localhost:%PORT% with your browser ***
docker run -p %PORT%:80 -v "%VOLUME%:/home/user/catkin_ws/src" --shm-size=512m --name %1 ubuntu-desktop:latest