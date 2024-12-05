# Use Windows Server Core as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Use PowerShell as the default shell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Step 1: Install NuGet and BcContainerHelper
RUN Install-PackageProvider -Name NuGet -Force; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    if (!(Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue)) { \
        Register-PSRepository -Default; \
    } else { \
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
    }
RUN Install-Module -Name 'BcContainerHelper' -Force -AllowClobber;

# Step 2: Start IIS or Business Central Web Server (adjust path if required)
RUN Install-WindowsFeature -Name Web-Server; \
    Start-Service W3SVC;

# Default command to keep the container running
ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
