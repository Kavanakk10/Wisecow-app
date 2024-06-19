#Use an official Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variable to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages: fortune-mod, cowsay, and netcat
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat && \
    apt-get clean

# Copy the wisecow.sh script into the container
COPY wisecow.sh /usr/local/bin/wisecow.sh

# Make the wisecow.sh script executable
RUN chmod +x /usr/local/bin/wisecow.sh

# Set the command to run the wisecow.sh script
CMD ["/usr/local/bin/wisecow.sh"]