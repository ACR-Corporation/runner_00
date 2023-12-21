# Use an official Alpine Linux as a base image
FROM alpine:latest

# Define environment variable for Terraform version
ENV TERRAFORM_VERSION=1.6.5

# Install dependencies
RUN apk add --update curl unzip

# Download and install Terraform
RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Verify installation
RUN terraform --version

# Set work directory
WORKDIR /app

# Copy the rest of the application
COPY . /app