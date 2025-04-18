#!/bin/bash
# =============================================================================
# run.sh - Cross-Platform Script for Ride Sharing System
# =============================================================================

set -e

# ----------- OS Detection -----------
OS=$(uname)
machine=""
case "$OS" in
    Linux*)   machine="Linux" ;;
    Darwin*)  machine="macOS" ;;
    MINGW*|MSYS*|CYGWIN*) machine="Windows" ;;
    *)        machine="UNKNOWN" ;;
esac

echo "----------------------------------------------"
echo "Detected Operating System: $machine ($OS)"
echo "----------------------------------------------"

# ----------- Check for g++ -----------
if ! command -v g++ &>/dev/null; then
    echo "Error: g++ is not installed."
    echo "Please install g++ (or a C++ compiler) and re-run this script."
    exit 1
fi

# ----------- Compile C++ File -----------
mkdir -p build
echo "----------------------------------------------"
echo "Compiling C++ source file 'RideSharingSystem.cpp'..."
echo "----------------------------------------------"

if [ "$machine" == "Windows" ]; then
    if ! g++ -std=c++11 -o build/ridesharing.exe RideSharingSystem.cpp ; then
        echo "Compilation failed (Windows). Please check RideSharingSystem.cpp for errors."
        exit 1
    fi
    EXECUTABLE="./build/ridesharing.exe"
else
    if ! g++ -std=c++11 -o build/ridesharing RideSharingSystem.cpp ; then
        echo "Compilation failed (Linux/macOS). Please check RideSharingSystem.cpp for errors."
        exit 1
    fi
    EXECUTABLE="./build/ridesharing"
fi

echo "Compilation successful."

# ----------- Run C++ Executable -----------
echo "----------------------------------------------"
echo "Running the C++ executable (RideSharingSystem)..."
echo "----------------------------------------------"
$EXECUTABLE &   # <--- Run in background!

# ----------- Run Smalltalk Program -----------
echo "----------------------------------------------"
echo "Launching Smalltalk RideSharingSystem.st..."
echo "----------------------------------------------"

# Make sure alias is usable inside the script (use full path instead for reliability)
PHARO_LAUNCHER="/Applications/PharoLauncher.app/Contents/Resources/pharo-launcher"
PHARO_IMAGE_NAME="myImage"
SMALLTALK_FILE="/Users/labaik/Documents/GitHub/MSCS632_Assignment_5/src/RideSharingSystem.st"

echo "Image Name: $PHARO_IMAGE_NAME"
echo "File Location: $SMALLTALK_FILE"

# Check if pharo-launcher exists
if [ ! -f "$PHARO_LAUNCHER" ]; then
    echo "Error: Pharo Launcher not found at $PHARO_LAUNCHER"
    exit 1
fi

# Run Smalltalk evaluation
"$PHARO_LAUNCHER" image launch --headless "$PHARO_IMAGE_NAME" --eval "$(cat "$SMALLTALK_FILE")" &
smalltalk_pid=$!

# ----------- Wait for both processes -----------
wait $smalltalk_pid

echo "----------------------------------------------"
echo "Script completed successfully."
