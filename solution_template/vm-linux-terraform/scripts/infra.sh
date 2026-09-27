```bash
#!/bin/bash

# This file is intentionally just a script.
# It will NOT execute unless you explicitly run:
# bash install-tools.sh

set -e

echo "Updating package information..."
sudo apt-get update

echo "Installing required packages..."
sudo apt-get install -y \
    curl \
    unzip \
    jq \
    gnupg \
    ca-certificates \
    lsb-release

# ------------------------------------------------------------
# Install Terraform from the official HashiCorp APT repository
# ------------------------------------------------------------

echo "Setting up HashiCorp repository..."

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor \
    -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg

sudo chmod 644 /etc/apt/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt-get update

echo "Installing Terraform..."
sudo apt-get install -y terraform

echo "Terraform version:"
terraform version

# ------------------------------------------------------------
# Install Azure CLI from Microsoft's official repository
# ------------------------------------------------------------

echo "Setting up Microsoft Azure CLI repository..."

sudo mkdir -p /etc/apt/keyrings

curl -sLS https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null

sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_DIST=$(lsb_release -cs)

echo "Types: deb
URIs: https://packages.microsoft.com/repos/
```
