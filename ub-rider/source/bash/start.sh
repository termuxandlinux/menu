#!/bin/bash

# ASCII Art banner
echo "
  ____            _      _  __ _     
 |  _ \  ___  ___| |_ __| |/ _(_)_ __
 | | | |/ _ \/ __| __/ _\` | |_| | '__|
 | |_| |  __/ (__| || (_| |  _| | |   
 |____/ \___|\___|\__\__,_|_| |_|_|   
"

# Main menu function
main_menu() {
    echo "[1] pkg"
    echo "[2] pkgo"
    echo "[3] apt"
    read -p "Enter your choice: " choice

    case $choice in
        1) pkg_menu ;;
        2) pkgo_menu ;;
        3) apt_menu ;;
        *) echo "Invalid choice" ;;
    esac
}

# pkg menu function
pkg_menu() {
    echo "[1] install"
    echo "[2] search"
    echo "[3] update"
    read -p "Enter your choice: " pkg_choice

    case $pkg_choice in
        1) read -p "which package: " package_name
           pkg install -y $package_name ;;
        2) read -p "which package: " package_name
           pkg search $package_name ;;
        3) pkg update ;;
        *) echo "Invalid choice" ;;
    esac
}

# pkgo menu function
pkgo_menu() {
    echo "[1] -i"
    echo "[2] -u"
    echo "[3] -d"
    read -p "Enter your choice: " pkgo_choice

    case $pkgo_choice in
        1) read -p "which package: " package_name
           pkgo -i $package_name ;;
        2) read -p "which package: " package_name
           pkgo -u $package_name ;;
        3) read -p "which package: " package_name
           pkgo -d $package_name ;;
        *) echo "Invalid choice" ;;
    esac
}

# apt menu function
apt_menu() {
    echo "[1] install"
    echo "[2] search"
    echo "[3] update"
    echo "[4] upgrade"
    read -p "Enter your choice: " apt_choice

    case $apt_choice in
        1) read -p "which package: " package_name
           apt install -y $package_name ;;
        2) read -p "which package: " package_name
           apt search $package_name ;;
        3) apt update ;;
        4) apt upgrade ;;
        *) echo "Invalid choice" ;;
    esac
}

# Main program
main_menu
