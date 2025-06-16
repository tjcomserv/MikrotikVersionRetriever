#!/bin/bash

# URL of the MikroTik changelog page
url="https://mikrotik.com/download/changelogs"

# File to store the downloaded HTML
html_file="mikrotik_changelog.html"

# Download the HTML
curl -s "$url" -o "$html_file"

# Function to find and extract the version for a given release tree
extract_version() {
    local tree_name="$1"
    # Find the line number of the release tree
    local start_line=$(grep -n "$tree_name$" "$html_file" | cut -d: -f1)
    if [ -z "$start_line" ]; then
        return
    fi

    # Find the next occurrence of "c-stable-v", "c-longTerm-v", etc., starting from the start line
    local release_line=$(tail -n +$start_line "$html_file" | grep -n "c-stable-v\|c-longTerm-v\|c-testing-v\|c-development-v" | head -n 1 | cut -d: -f1)
    if [ -n "$release_line" ]; then
        # Calculate the actual line number
        local actual_line=$((start_line + release_line - 1))
        # Extract the line content
        local line_content=$(sed -n "${actual_line}p" "$html_file")
        # Extract the full version number, including beta/rc suffixes
        local version=$(echo "$line_content" | sed -n 's/.*c-\(stable\|longTerm\|testing\|development\)-v\([0-9_.a-zA-Z-]\+\).*/\2/p' | tr '_' '.')
        echo "$version"
    fi
}

# Parse the input argument
case "$1" in
    -s) extract_version "Stable release tree" ;;
    -d) extract_version "Development release tree" ;;
    -l) extract_version "Long-term release tree" ;;
    -t) extract_version "Testing release tree" ;;
    *)
        echo "Usage: $0 [-s | -d | -l | -t]"
        echo "  -s: Return the latest Stable release"
        echo "  -d: Return the latest Development release"
        echo "  -l: Return the latest Long-term release"
        echo "  -t: Return the latest Testing release"
        ;;
esac

rm $html_file
