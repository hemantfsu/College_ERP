#!/bin/bash

echo "🚀 Starting College ERP Setup..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    echo "❌ Node.js is not installed!"
    echo ""
    echo "Please install Node.js first:"
    echo "Option 1: brew install node"
    echo "Option 2: Download from https://nodejs.org/"
    echo ""
    exit 1
fi

echo "✅ Node.js found: $(node --version)"
echo "✅ npm found: $(npm --version)"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found!"
    echo "Please run this script from the college-erp directory"
    exit 1
fi

echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Dependencies installed successfully!"
    echo ""
    echo "🎉 Starting development server..."
    echo ""
    npm run dev
else
    echo ""
    echo "❌ Installation failed!"
    echo "Try running: npm cache clean --force"
    echo "Then run this script again"
    exit 1
fi
