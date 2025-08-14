# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# install required packages for system
RUN apt-get update \  
    && apt-get upgrade -y \  
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*
# apt-get update - Updates the package index (metadata of available packages). Must be done before installing anything with apt.
# Upgrades all installed packages to the latest available versions. The -y flag auto-confirms the upgrade prompts.⚠️ Usually not needed in Dockerfiles, unless you specifically want upgraded system packages. It can increase build time and image size.
# gcc - C compiler — required for building some Python packages from source (e.g. mysqlclient)
# default-libmysqlclient-dev - Development files needed to compile MySQL-related libraries (e.g. Python, PHP, etc.)
# pkg-config - Tool that helps find compile and link flags for installed libraries

# Copy the requirements file into the container
COPY requirements.txt .

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt
# Cleans up cached package metadata after installation.
# Helps reduce image size.
# Best practice in Dockerfiles

# Copy the rest of the application code
COPY . .

# Specify the command to run your application
CMD ["python", "app.py"]

