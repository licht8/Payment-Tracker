#!/bin/bash

# Function for checking and installing the bc package
check_and_install_bc() {
    if ! command -v bc >/dev/null 2>&1; then
        echo "The 'bc' package is not found. Installing the 'bc' package..."
        if command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y bc >/dev/null 2>&1
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y bc >/dev/null 2>&1
        else
            echo "Failed to install the 'bc' package. Please install it manually."
            exit 1
        fi
        echo "The 'bc' package successfully installed."
    fi
}
