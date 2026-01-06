#!/bin/bash

# ==============================================================================
# Full Environment Setup Script for Ubuntu
# Author: Antigravity AI
# Description: Installs project dependencies (Docker, Java, Node, etc.)
#              and desktop applications (Telegram, Steam, Discord, AIMP, etc.)
# ==============================================================================

set -e # Exit on error

echo "🚀 Starting Full System Setup..."

# 1. Update and Basic Tools
echo "------------------------------------------------"
echo "📦 Updating system and installing base tools..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git ca-certificates gnupg lsb-release htop software-properties-common apt-transport-https

# 2. Hardware Drivers (Check and Install)
echo "------------------------------------------------"
echo "🛠️ Checking for hardware drivers..."
sudo ubuntu-drivers autoinstall || echo "No additional drivers found or autoinstall failed."

# 3. Java 17 (OpenJDK)
echo "------------------------------------------------"
echo "☕ Installing Java 17 (OpenJDK)..."
sudo apt install -y openjdk-17-jdk

# 4. Build Tools (Maven & Yarn/Node)
echo "------------------------------------------------"
echo "🏗️ Installing Build Tools (Maven, Node.js, Yarn)..."
sudo apt install -y maven

# Install Node.js (Latest LTS)
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Install Yarn
sudo npm install --global yarn

# 5. Docker Desktop
echo "------------------------------------------------"
echo "🐳 Installing Docker Desktop..."
# Prereqs for Docker Desktop
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y
sudo adduser $USER libvirt
sudo adduser $USER kvm

# Download and Install Docker Desktop .deb
DOCKER_DEB_URL="https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
wget -O /tmp/docker-desktop.deb $DOCKER_DEB_URL
sudo apt update
sudo apt install -y /tmp/docker-desktop.deb
rm /tmp/docker-desktop.deb

# 6. Antigravity AI Assistant
echo "------------------------------------------------"
echo "🤖 Installing Antigravity AI..."
sudo apt install -y antigravity || echo "Note: Antigravity might require manual PPA or deb depending on your Ubuntu version."

# 7. Desktop & Media Apps (via Snap)
echo "------------------------------------------------"
echo "🖥️ Installing Desktop Apps (Snap)..."
sudo snap install telegram-desktop
sudo snap install discord
sudo snap install steam
sudo snap install chromium
sudo snap install vlc
sudo snap install dbeaver-ce
sudo snap install intellij-idea-community --classic

# Windows-style apps (NotePad++, AIMP) via Wine-wrapped snaps
echo "------------------------------------------------"
echo "🪟 Installing Windows-style apps (Wine-wrapped Snaps)..."
sudo snap install notepad-plus-plus
sudo snap install aimp --edge || echo "Note: AIMP might be in edge or candidate channel."

# 8. Final Cleanup and Instructions
echo "------------------------------------------------"
echo "✅ Setup Complete!"
echo "------------------------------------------------"
echo "System must be restarted or you must logout/login for group changes (Docker/KVM) to take effect."
echo "You can now run 'antigravity' to start your AI assistant."
echo "------------------------------------------------"
