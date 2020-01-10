# Dockerfile for creating OpenSSH for Windows image.
# The OpenSSH binaries were downloaded for
# https://github.com/PowerShell/Win32-OpenSSH/releases
#

# Windows 2019 for now.
ARG TAG=1809
#FROM mcr.microsoft.com/windows/nanoserver:$TAG
FROM  mcr.microsoft.com/windows/servercore:$TAG
LABEL maintainer="Chevah Project <dev@chevah.com>"

EXPOSE 22

# Copy the files and then start the image setup.
copy storage/ c:/build
run c:/build/setup.bat

# We use CMD to make it easier to overwring and debug from docker run.
CMD ["c:/run/ServiceMonitor", "sshd"]
