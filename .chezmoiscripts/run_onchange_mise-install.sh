#!/bin/bash

if ! command -v mise >/dev/null 2>&1; then
    echo "Mise is not installed. Please install Mise to run this script."
    exit 1
fi

echo "Installing languages and tools with Mise..."
mise install