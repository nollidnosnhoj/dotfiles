#!/bin/bash

set -euo pipefail

if ! command -v mise >/dev/null 2>&1; then
    echo "Mise is not installed. Installing mise..."
    curl https://mise.run | sh
fi

echo "Installing languages and tools with Mise..."
mise install
