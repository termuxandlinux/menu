#!/bin/bash

URL_FILE="$HOME/.url/url.txt"
CACHE_DIR="$HOME/.pkgo/cache"

# Ensure the cache directory exists
mkdir -p "$CACHE_DIR"

# Check if any arguments are provided
if [ $# -eq 0 ]; then
    echo "Please provide arguments."
    exit 1
fi

# Handle special cache commands
if [ "$1" = "--cache" ]; then
    if [ $# -ne 2 ]; then
        echo "Invalid usage. Use --cache [setup|list]"
        exit 1
    fi

    case "$2" in
        "setup")
            echo "Cache directory is already set up at $CACHE_DIR."
            ;;
        "list")
            echo "Listing cached packages:"
            ls "$CACHE_DIR"
            ;;
        *)
            echo "Unknown cache command. Available commands are: setup, list"
            exit 1
            ;;
    esac
    exit 0
fi

# Function for handling the package operations
handle_package_operation() {
    local operation=$1
    local packageName=$2
    local cacheOption=$3
    local basePath=""
    local fullUrl=""

    while read -r url; do
        case "$operation" in
            "-u")
                basePath="$url/${packageName}/pkg/new"
                ;;
            "-d")
                basePath="$url/${packageName}/pkg/old"
                ;;
            *)
                basePath="$url/${packageName}/pkg"
                ;;
        esac

        fullUrl="${basePath}/${packageName}.deb"
        echo "Attempting to download: $fullUrl"

        if wget -O "$CACHE_DIR/${packageName}.deb" "$fullUrl"; then
            echo "Download successful: ${packageName}.deb"
            if [ "$cacheOption" != "c" ]; then
                echo "Installing ${packageName}.deb"
                dpkg -i "$CACHE_DIR/${packageName}.deb"
            else
                echo "Package cached: ${packageName}.deb"
            fi
            return 0
        else
            echo "Failed to download: ${packageName}.deb"
        fi
    done < "$URL_FILE"

    echo "Operation failed for package: $packageName"
    return 1
}

# Handle installation from cache
if [ "$1" = "-c" ]; then
    if [ $# -ne 2 ]; then
        echo "Usage: $0 -c <package_name>"
        exit 1
    fi

    packageName=$2
    cachedFilePath="$CACHE_DIR/${packageName}.deb"

    if [ -f "$cachedFilePath" ]; then
        echo "Installing $packageName from cache"
        dpkg -i "$cachedFilePath"
        exit 0
    else
        echo "Package $packageName not found in cache."
        exit 1
    fi
fi

# Parse the first argument to determine the operation for download and optionally caching
if [[ "$1" == "-u" || "$1" == "-d" || "$1" == "-i" ]]; then
    if [ $# -lt 2 ] || ([ "$1" == "-i" ] && [ $# -gt 3 ]); then
        echo "Usage: $0 $1 <package_name> [c]"
        exit 1
    fi
    handle_package_operation "$1" "$2" "$3"
    exit 0
fi

echo "Invalid arguments provided."
exit 1
