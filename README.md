# Bazaar & KRunner Plugin Installer for Fedora 42

This script automates the complete installation of the [Bazaar](https://github.com/kolunmi/bazaar) application and its companion [KRunner plugin](https://github.com/ublue-os/krunner-bazaar) on a Fedora 42 KDE Plasma system.

It handles downloading the source code, installing all required dependencies, compiling both projects, and installing them to the correct system locations.

## Features

-   **Fully Automated**: Single script to install everything from start to finish.
-   **Dependency Resolution**: Installs all required development packages for both Bazaar and the KRunner plugin.
-   **Clean Installation**: Clones the latest source code from the official repositories.
-   **KDE Integration**: Installs and restarts the KRunner plugin for immediate use.

## Requirements

-   **Operating System**: Fedora 42 (KDE Plasma Desktop Edition)
-   **Architecture**: x86_64
-   **Permissions**: You will need `sudo` access to install packages and write to system directories.

## How to Use

1.  **Save the Script**: Save the script from the main document as `install_bazaar.sh`.

2.  **Make it Executable**: Open a terminal in the directory where you saved the file and run:
    ```bash
    chmod +x install_bazaar.sh
    ```

3.  **Run the Script**: Execute the script from your terminal:
    ```bash
    ./install_bazaar.sh
    ```

The script will then guide you through the process. You will be prompted for your password for `sudo` commands.

## What the Script Does

1.  **Updates System**: Runs `sudo dnf update -y` to ensure your system is up to date.
2.  **Installs Dependencies**: Installs all necessary packages for building both projects, including `meson`, `cmake`, `gcc`, and various `-devel` packages for GTK4, KDE Frameworks 6, and other libraries.
3.  **Clones Repositories**: Downloads the latest source code for `bazaar` and `krunner-bazaar` from GitHub into your home directory.
4.  **Builds & Installs Bazaar**: Configures, compiles, and installs the main Bazaar application.
5.  **Builds & Installs KRunner Plugin**: Configures, compiles, and installs the KRunner integration plugin.
6.  **Restarts KRunner**: Restarts the KRunner service so it can immediately detect and use the new plugin.

After the script is finished, you can find Bazaar in your application launcher and use the KRunner plugin by pressing `Alt+F2` (or `Alt+Space`) and typing `bazaar <search-term>`.
