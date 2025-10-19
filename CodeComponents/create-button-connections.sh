#!/bin/bash

# Script to help create Figma Connect files for button components
# Usage: ./create-button-connections.sh

echo "🔗 Figma Connect - Button Component Setup Helper"
echo "=================================================="
echo ""
echo "This script will help you create Figma Connect files for your button components."
echo ""
echo "📋 Step 1: Get Component URLs from Figma"
echo "   1. Open: https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0"
echo "   2. Switch to Dev Mode"
echo "   3. Select a button component"
echo "   4. Copy the URL from your browser"
echo ""
echo "📝 Step 2: Generate Code Connect Files"
echo ""

# Array of button types to create
declare -a button_types=(
    "Primary-Large"
    "Primary-Medium"
    "Primary-Small"
    "Secondary-Large"
    "Secondary-Medium"
    "Secondary-Small"
    "Tertiary-Large"
    "Tertiary-Medium"
    "Tertiary-Small"
    "Destructive-Large"
    "Destructive-Medium"
    "Destructive-Small"
)

echo "We'll create connections for these button types:"
for type in "${button_types[@]}"; do
    echo "  - $type"
done
echo ""

read -p "Do you want to create these files interactively? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for type in "${button_types[@]}"; do
        echo ""
        echo "🔘 Creating connection for: $type"
        read -p "   Paste the Figma URL for $type button (or press Enter to skip): " figma_url
        
        if [ ! -z "$figma_url" ]; then
            echo "   Generating Code Connect file..."
            npx figma connect create "$figma_url" \
                --outDir CodeComponents/Sources/SwiftUI/Buttons \
                --outFile "WegoButton-$type.figma.swift"
            
            if [ $? -eq 0 ]; then
                echo "   ✅ Created WegoButton-$type.figma.swift"
            else
                echo "   ❌ Failed to create file"
            fi
        else
            echo "   ⏭️  Skipped"
        fi
    done
    
    echo ""
    echo "✨ Done! Now you can:"
    echo "   1. Edit the generated files to use WegoButtonView"
    echo "   2. Run: npx figma connect publish"
    echo "   3. Check Figma Dev Mode to see your code!"
else
    echo ""
    echo "📖 Manual Setup Instructions:"
    echo ""
    echo "For each button component in Figma:"
    echo "  1. Copy the component URL"
    echo "  2. Run: npx figma connect create <URL> --outDir CodeComponents/Sources/SwiftUI/Buttons"
    echo "  3. Edit the generated file to use WegoButtonView"
    echo ""
    echo "Or edit the WegoButton.figma.swift file we already created!"
    echo "See FIGMA_CONNECT_SETUP_GUIDE.md for detailed instructions."
fi

echo ""
echo "=================================================="

