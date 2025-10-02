# Installation Guide - College ERP System

## Prerequisites Installation

### Step 1: Install Node.js

#### macOS (using Homebrew)
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js (includes npm)
brew install node

# Verify installation
node --version
npm --version
```

#### Alternative: Direct Download
1. Visit https://nodejs.org/
2. Download the LTS version (v18 or higher)
3. Run the installer
4. Verify installation in terminal:
   ```bash
   node --version
   npm --version
   ```

## Project Setup

### Step 2: Install Project Dependencies

```bash
# Navigate to project directory
cd /Users/hemantbaghel/Desktop/college-erp

# Install all dependencies
npm install
```

This will install:
- React 18.2.0
- React Router DOM 6.21.0
- Recharts 2.10.3
- Lucide React 0.294.0
- jsPDF 2.5.1
- date-fns 2.30.0
- Vite 5.0.8
- TypeScript 5.2.2
- Tailwind CSS 3.3.6
- And all dev dependencies

### Step 3: Start Development Server

```bash
# Start the dev server
npm run dev
```

The application will be available at `http://localhost:3000`

### Step 4: Build for Production

```bash
# Create production build
npm run build

# Preview production build
npm run preview
```

## Troubleshooting

### Port Already in Use
If port 3000 is occupied, the Vite dev server will automatically use the next available port (3001, 3002, etc.)

### Node Version Issues
Ensure you're using Node.js v18 or higher:
```bash
node --version
```

### Clear Cache
If you encounter build issues:
```bash
# Remove node_modules and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Permission Issues
On macOS, you might need to use sudo for global packages:
```bash
sudo npm install -g npm@latest
```

## Development Workflow

### Running in Development Mode
```bash
npm run dev
```
- Hot Module Replacement (HMR) enabled
- Changes reflect instantly
- TypeScript type checking
- Tailwind CSS compilation

### Building for Production
```bash
npm run build
```
- Optimized bundle
- Minified assets
- Tree-shaking
- Output in `dist/` folder

### Linting
```bash
npm run lint
```
Checks for code quality issues

## Environment Setup

### Optional: Environment Variables
Create a `.env` file in the root directory:

```env
# API endpoints (for future integrations)
VITE_API_URL=http://localhost:8000
VITE_GOOGLE_SHEETS_API_KEY=your_key_here
VITE_GOOGLE_DRIVE_API_KEY=your_key_here

# Feature flags
VITE_ENABLE_CLOUD_SYNC=false
VITE_ENABLE_EMAIL=false
```

## Next Steps

1. ✅ Install Node.js and npm
2. ✅ Run `npm install`
3. ✅ Run `npm run dev`
4. 🎉 Access the application at http://localhost:3000
5. 👤 Use Settings page to switch between roles
6. 📝 Start testing features!

## Quick Test

To verify everything is working:

1. Open http://localhost:3000
2. You should see the Dashboard
3. Click "Admissions" in the sidebar
4. Click "New Admission" button
5. Fill the form and submit
6. Check if the student appears in the table

## Support

If you encounter issues:
1. Check console for errors (F12 in browser)
2. Verify Node.js version is 18+
3. Ensure all dependencies installed correctly
4. Check the terminal for any build errors

For more help, refer to the main README.md file.
