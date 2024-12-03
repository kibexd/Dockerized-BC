# Use PowerShell Core image
FROM mcr.microsoft.com/powershell:latest

# Install necessary PowerShell modules
RUN pwsh -Command "Install-Module -Name 'Microsoft.Dynamics.Nav.ContainerHelper' -Force" \
    && pwsh -Command "Install-Module -Name 'BcContainerHelper' -Force"

# Copy setup scripts
COPY setup.ps1 /scripts/setup.ps1

# Set working directory
WORKDIR /scripts

# Default entrypoint
ENTRYPOINT ["pwsh", "-File", "setup.ps1"]