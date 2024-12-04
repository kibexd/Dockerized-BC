# Use Windows Server Core as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Use PowerShell as the default shell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Step 1: Ensure the NuGet Provider is installed and up-to-date
RUN Install-PackageProvider -Name NuGet -Force; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
    Register-PSRepository -Name 'PSGallery' -SourceLocation 'https://www.powershellgallery.com/api/v2' -InstallationPolicy Trusted;

# Step 2: Install the BcContainerHelper module
RUN Install-Module -Name 'BcContainerHelper' -Force -AllowClobber;

# Step 3: Additional custom setup if needed
COPY my-init-script.ps1 C:/Run/

# Step 4: Run your script (if applicable)
RUN powershell -ExecutionPolicy Bypass -File C:/Run/my-init-script.ps1

# Expose ports (adjust as needed for Business Central)
EXPOSE 80 443
