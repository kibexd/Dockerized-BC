# Use an official Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install necessary tools
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install PowerShell and BC Container Helper
RUN Install-PackageProvider -Name NuGet -Force; \
    Install-Module -Name 'Microsoft.Dynamics.Nav.ContainerHelper' -Force

# Set working directory
WORKDIR /bc-setup

# Copy any necessary setup scripts
COPY setup.ps1 ./

# Default command to set up Business Central
CMD ["powershell", "-File", "setup.ps1"]