# Use Windows Server Core as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Use PowerShell as the default shell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Step 1: Ensure the NuGet Provider is installed and up-to-date
RUN Install-PackageProvider -Name NuGet -Force; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    if (!(Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue)) { \
        Register-PSRepository -Default; \
    } else { \
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
    }

# Step 2: Install the BcContainerHelper module
RUN Install-Module -Name 'BcContainerHelper' -Force -AllowClobber;

# Expose ports (adjust as needed for Business Central)
EXPOSE 80 443
