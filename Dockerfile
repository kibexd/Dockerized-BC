# Use Business Central base image
FROM mcr.microsoft.com/dynamics-nav:latest

# Optional: Add maintainer information
LABEL maintainer="Your Name <your.email@example.com>"

# Expose ports for web and development access
EXPOSE 80 443

# Default command
CMD ["pwsh"]