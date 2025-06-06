FROM jenkins/inbound-agent:latest-jdk17

# Update all packages to the latest versions to reduce vulnerabilities
#RUN apk update && apk upgrade --no-cache

USER root

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

USER jenkins

