#!/bin/bash

# URL of the MikroTik changelog page
url="https://mikrotik.com/download/changelogs"

# Download the HTML content into memory
html_content=$(curl -s "$url")

# Function to find and extract the version for a given release tree
extract_version() {
    local tree_name="$1"
    local html="$2"

    # Find line number of the release tree
    local start_line=$(echo "$html" | grep -n "$tree_name$" | cut -d: -f1 | head -n1)
    if [ -z "$start_line" ]; then
        return
    fi

    # Get the tail of the content starting from the release tree
    local tail_html=$(echo "$html" | tail -n +"$start_line")

    # Find the first release line matching the expected class names
    local line_content=$(echo "$tail_html" | grep -m 1 "c-stable-v\|c-longTerm-v\|c-testing-v\|c-development-v")

    # Extract the version number
    local version=$(echo "$line_content" | sed -n 's/.*c-\(stable\|longTerm\|testing\|development\)-v\([0-9_.a-zA-Z-]\+\).*/\2/p' | tr '_' '.')

    echo "$version"
}

# Parse the input argument
case "$1" in
    -s) extract_version "Stable release tree" "$html_content" ;;
    -d) extract_version "Development release tree" "$html_content" ;;
    -l) extract_version "Long-term release tree" "$html_content" ;;
    -t) extract_version "Testing release tree" "$html_content" ;;
    *)
        echo "Usage: $0 [-s | -d | -l | -t]"
        echo "  -s: Returns the latest Stable release"
        echo "  -d: Returns the latest Development release"
        echo "  -l: Returns the latest Long-term release"
        echo "  -t: Returns the latest Testing release"
        ;;
esac
