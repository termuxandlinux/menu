#!/bin/bash

URL_FILE="$HOME/.url/url.txt"

# Create cache directory if it does not exist
mkdir -p "$HOME/.pkgo/cache"

# Check if any arguments are provided
if [ $# -eq 0 ]; then
    echo "Please provide arguments."
    exit 1
fi

# Handle special cache commands
if [ "$1" = "--cache" ]; then
    case "$2" in
        "setup")
            echo "Cache directory is set up at $HOME/.pkgo/cache."
            exit 0
            ;;
        "list")
            echo "Cached packages:"
            ls "$HOME/.pkgo/cache"
            exit 0
            ;;
        *)
            echo "Invalid cache command. Use 'setup' or 'list'."
            exit 1
            ;;
    esac
fi

# Function for downloading and optionally caching packages
download_package() {
    local url_path="$1"
    local package_name="$2"
    local cache="$3"
    local full_url="${url_path}/${package_name}.deb"
    echo "Downloading from: $full_url"
    wget "$full_url" -O "${package_name}.deb"
    if [ $? -eq 0 ]; then
        if [ "$cache" = "c" ]; then
            echo "Caching package: ${package_name}"
            mv "${package_name}.deb" "$HOME/.pkgo/cache/"
        else
            echo "Installing ${package_name}."
            dpkg -i "${package_name}.deb"
            rm -f "${package_name}.deb"
        fi
        exit 0
    else
        echo "Failed to download package: $package_name"
        exit 1
    fi
}

# Handle cache installation
if [ "$1" = "-c" ]; then
    if [ $# -ne 2 ]; then
        echo "Usage: $0 -c <package_name>"
        exit 1
    fi
    package_name="$2"
    cached_file="$HOME/.pkgo/cache/${package_name}.deb"
    if [ -f "$cached_file" ]; then
        echo "Installing package from cache: $package_name"
        dpkg -i "$cached_file"
        exit 0
    else
        echo "Package not found in cache: $package_name"
        exit 1
    fi
fi

# Handle package commands with optional caching
case "$1" in
    "-u" | "-d" | "-i")
        if [ $# -lt 3 ] || ([ "$4" != "" ] && [ "$4" != "c" ]); then
            echo "Usage: $0 $1 <package_name> [c]"
            exit 1
        fi
        package_name="$2"
        cache_option="$4"
        while read -r base_url; do
            case "$1" in
                "-u") url_path="$base_url/$package_name/pkg/new" ;;
                "-d") url_path="$base_url/$package_name/pkg/old" ;;
                "-i") url_path="$base_url/$package_name/pkg" ;;
            esac
            download_package "$url_path" "$package_name" "$cache_option"
            break  # Assuming only one URL is used for simplicity
        done < "$URL_FILE"
        ;;
    *)
        echo "Invalid arguments provided."
        exit 1
        ;;
esac
