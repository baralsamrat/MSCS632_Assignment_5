# #!/bin/bash
# # =============================================================================
# # run.sh - Cross-Platform Script for Ride Sharing System
# #
# # This script performs the following:
# #   1. Detects the operating system.
# #   2. Checks for g++ (C++ compiler) installation.
# #   3. Creates a build directory and compiles the C++ source (RideSharingSystem.cpp).
# #   4. Exits if compilation fails (for example, due to linking errors like exit status 116).
# #   5. Runs the compiled C++ executable.
# #   6. Provides instructions for running the Smalltalk version.
# #
# # Usage:
# #   $ chmod +x run.sh
# #   $ ./run.sh
# #
# # Note: On Windows, run this script in a POSIX-compliant shell (e.g., Git Bash).
# # =============================================================================

# # Exit immediately if a command exits with a non-zero status.
# set -e

# # Detect OS type using uname.
# OS=$(uname)
# machine=""

# case "$OS" in
#     Linux*)   machine="Linux" ;;
#     Darwin*)  machine="macOS" ;;
#     MINGW*|MSYS*|CYGWIN*) machine="Windows" ;;
#     *)        machine="UNKNOWN" ;;
# esac

# echo "----------------------------------------------"
# echo "Detected Operating System: $machine ($OS)"
# echo "----------------------------------------------"

# # Check for g++ compiler.
# if ! command -v g++ &>/dev/null; then
#     echo "Error: g++ is not installed."
#     echo "Please install g++ (or a C++ compiler) and re-run this script."
#     exit 1
# fi

# # Create build directory (if it doesn't exist)
# mkdir -p build

# echo "----------------------------------------------"
# echo "Compiling C++ source file 'RideSharingSystem.cpp'..."
# echo "----------------------------------------------"

# # Compile the C++ source file and check for errors.
# if [ "$machine" == "Windows" ]; then
#     if ! g++ -std=c++11 -o build/ridesharing.exe RideSharingSystem.cpp ; then
#         echo "Compilation failed (Windows). Please check RideSharingSystem.cpp for errors."
#         exit 1
#     fi
#     EXECUTABLE="./build/ridesharing.exe"
# else
#     if ! g++ -std=c++11 -o build/ridesharing RideSharingSystem.cpp ; then
#         echo "Compilation failed (Linux/macOS). Please check RideSharingSystem.cpp for errors."
#         exit 1
#     fi
#     EXECUTABLE="./build/ridesharing"
# fi

# echo "Compilation successful."
# echo "----------------------------------------------"
# echo "Running the C++ executable..."
# echo "----------------------------------------------"
# $EXECUTABLE

# echo "----------------------------------------------"
# echo "Smalltalk Implementation Reminder:"
# echo "----------------------------------------------"
# echo "For the Smalltalk version, please open your Smalltalk image (e.g., Pharo, Squeak, etc.)"
# echo "and load the 'RideSharingSystem.st' file manually using the image's file browser or command line tools."
# echo "----------------------------------------------"
# echo "Script completed successfully."

#!/bin/bash
alias pharo-launcher='/Applications/PharoLauncher.app/Contents/Resources/pharo-launcher'
# Define the path to your Pharo image and the Smalltalk file
PHARO_IMAGE_NAME="myImage"
SMALLTALK_FILE="/Users/labaik/Documents/GitHub/MSCS632_Assignment_5/src/RideSharingSystem.st"

# Print the paths for debugging
echo "Image Name== $PHARO_IMAGE_NAME"
echo "File Location== $SMALLTALK_FILE"

# Use pharo-launcher to launch the Pharo image and run the Smalltalk file
echo "Begin=="
pharo-launcher image launch --headless $PHARO_IMAGE_NAME --eval "$(cat "$SMALLTALK_FILE")"
exit_status=$?
if [ $exit_status -ne 0 ]; then
    echo "Error: pharo-launcher command failed with exit status $exit_status"
fi
echo "End=="