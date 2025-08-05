#!/bin/bash

# ==============================================================================
# Bazaar & KRunner Plugin Installer for Fedora 42 (KDE Plasma) x86_64
#
# This script automates the process of downloading, compiling, and installing
# the Bazaar application and its KRunner integration plugin.
#
# It will:
# 1. Update system packages.
# 2. Install all necessary build dependencies for both projects.
# 3. Clone the Bazaar and KRunner plugin repositories.
# 4. Compile and install the Bazaar application.
# 5. Compile and install the KRunner plugin.
#
# Usage:
#   1. Save this file as "install_bazaar.sh"
#   2. Make it executable: chmod +x install_bazaar.sh
#   3. Run it: ./install_bazaar.sh
# ==============================================================================

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Introduction and Confirmation ---
echo -e "\e[1m\e[34mWelcome to the Bazaar & KRunner Plugin Installer for Fedora 42\e[0m"
echo "This script will install the Bazaar application, its KRunner plugin, and all dependencies."
echo "You will be prompted for your password for commands that require sudo."
echo ""
read -p "Do you wish to continue? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Installation cancelled."
    exit 1
fi

# --- Step 1: Update System Packages ---
echo -e "\n\e[1m\e[32m[1/6] Updating system packages...\e[0m"
sudo dnf update -y

# --- Step 2: Install Dependencies ---
echo -e "\n\e[1m\e[32m[2/6] Installing required dependencies for Bazaar and KRunner plugin...\e[0m"
# Dependencies for Bazaar and the KRunner plugin (which needs KDE Frameworks 6 dev packages).
sudo dnf install -y \
    git \
    meson \
    ninja-build \
    gcc \
    gcc-c++ \
    make \
    automake \
    autoconf \
    cmake \
    extra-cmake-modules \
    kf6-kcoreaddons-devel \
    kf6-ki18n-devel \
    kf6-krunner-devel \
    libadwaita-devel \
    flatpak-devel \
    libxmlb-devel \
    libyaml-devel \
    libsoup3-devel \
    glycin-devel \
    glycin-gtk4-devel \
    webkit2gtk4.0-devel \
    gtk4-devel \
    openssl-devel \
    libappindicator-gtk3-devel \
    librsvg2-devel \
    curl \
    wget

# --- Step 3: Clone the Bazaar Repository ---
if [ -d "$HOME/bazaar" ]; then
    echo -e "\n\e[1m\e[33mFound existing '$HOME/bazaar' directory. Removing for a fresh start.\e[0m"
    rm -rf "$HOME/bazaar"
fi

echo -e "\n\e[1m\e[32m[3/6] Cloning the Bazaar repository into '$HOME/bazaar'...\e[0m"
git clone https://github.com/kolunmi/bazaar.git "$HOME/bazaar"

# --- Step 4: Build and Install Bazaar ---
echo -e "\n\e[1m\e[32m[4/6] Building and installing Bazaar...\e[0m"
cd "$HOME/bazaar"

echo "--> Configuring Bazaar with Meson..."
meson setup build --prefix=/usr/local

echo "--> Compiling Bazaar with Ninja..."
ninja -C build

echo "--> Installing Bazaar (sudo required)..."
sudo ninja -C build install

# --- Step 5: Clone, Build, and Install KRunner Plugin ---
echo -e "\n\e[1m\e[32m[5/6] Cloning, building, and installing the KRunner plugin...\e[0m"
if [ -d "$HOME/krunner-bazaar" ]; then
    echo -e "\e[1m\e[33mFound existing '$HOME/krunner-bazaar' directory. Removing for a fresh start.\e[0m"
    rm -rf "$HOME/krunner-bazaar"
fi

echo "--> Cloning the KRunner plugin repository..."
git clone https://github.com/ublue-os/krunner-bazaar.git "$HOME/krunner-bazaar"
cd "$HOME/krunner-bazaar"

echo "--> Configuring KRunner plugin with CMake..."
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_USE_QT_SYS_PATHS=ON

echo "--> Compiling KRunner plugin..."
make

echo "--> Installing KRunner plugin (sudo required)..."
sudo make install

# --- Step 6: Finalizing ---
echo -e "\n\e[1m\e[32m[6/6] Finalizing installation...\e[0m"
# Restart KRunner to load the new plugin.
kquitapp5 krunner || true # Use || true to prevent script exit if it fails (e.g., not running)
kstart5 krunner || true

# --- Completion ---
echo -e "\n\e[1m\e[32m✅ Installation Complete! ✅\e[0m"
echo "Bazaar and its KRunner plugin have been successfully installed."
echo "You can find Bazaar in your Application Launcher."
echo "To use the plugin, open KRunner (Alt+Space or Alt+F2) and type 'bazaar' followed by a search term."
echo -e "If the plugin does not work immediately, please try logging out and back in."

exit 0
