# Use an official Windows base image that supports PowerShell
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Switch to PowerShell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install necessary components
RUN Install-PackageProvider -Name NuGet -Force; \
    Install-Module -Name 'Microsoft.Dynamics.Nav.ContainerHelper' -Force -AllowClobber; \
    Install-Module -Name 'BcContainerHelper' -Force -AllowClobber

# Set working directory
WORKDIR /bc-setup

# Copy deployment script
COPY deploy.ps1 .

# Default command to run deployment
CMD ["powershell", "-File", "deploy.ps1"]