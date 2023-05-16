#!/bin/bash

# Function for checking and installing the bc package
check_and_install_bc() {
    if ! command -v bc >/dev/null 2>&1; then
        echo "The 'bc' package is not found. Installing the 'bc' package..."
        if command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y bc
        elif command -v yum >/dev/null 2>&1; then
            sudo yum install -y bc
        else
            echo "Failed to install the 'bc' package. Please install it manually."
            exit 1
        fi
    fi
}
