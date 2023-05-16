#!/bin/bash

# Function for checking and installing the bc package
check_and_install_bc() {
    if ! command -v bc 2>/dev/null ; then
        echo "The 'bc' package is not found. Installing the 'bc' package..."
        if command -v dnf 2>/dev/null ; then
            sudo dnf install -y bc 2>/dev/null
        elif command -v yum 2>/dev/null ; then
            sudo yum install -y bc 2>/dev/null
        else
            echo "Failed to install the 'bc' package. Please install it manually."
            exit 1
        fi
    fi
}
