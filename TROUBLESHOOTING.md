# 🔧 Troubleshooting Guide - College ERP

## Quick Fix Steps

If the project is not running, follow these steps in order:

### Step 1: Install Node.js (If Not Installed)

Check if Node.js is installed:
```bash
node --version
npm --version
```

If not installed, install it:

**Option A: Using Homebrew (Recommended for macOS)**
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js
brew install node

# Verify installation
node --version  # Should show v18+ or v20+
npm --version   # Should show v9+ or v10+
```

**Option B: Direct Download**
1. Visit https://nodejs.org/
2. Download the LTS version (Long Term Support)
3. Run the installer
4. Verify in terminal: `node --version`

---

### Step 2: Navigate to Project Directory

```bash
cd /Users/hemantbaghel/Desktop/college-erp
```

---

### Step 3: Install Dependencies

```bash
npm install
```

This will install:
- React and React DOM
- React Router
- Tailwind CSS
- TypeScript
- Vite
- And all other dependencies

**Expected time**: 2-5 minutes depending on internet speed

**If you see errors**, try:
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm cache clean --force
npm install
```

---

### Step 4: Start Development Server

```bash
npm run dev
```

You should see output like:
```
  VITE v5.0.8  ready in 500 ms

  ➜  Local:   http://localhost:3000/
  ➜  Network: use --host to expose
  ➜  press h to show help
```

---

### Step 5: Open in Browser

Open your browser and go to:
```
http://localhost:3000
```

✅ **Success!** You should see the College ERP Dashboard.

---

## Common Issues & Solutions

### Issue 1: "npm: command not found"

**Problem**: Node.js is not installed

**Solution**: Install Node.js using Step 1 above

---

### Issue 2: "Cannot find module 'tailwindcss'"

**Problem**: Dependencies not installed

**Solution**:
```bash
npm install
```

---

### Issue 3: "Port 3000 is already in use"

**Problem**: Another application is using port 3000

**Solution 1** - Vite will automatically use another port (3001, 3002, etc.)
Just check the terminal output for the actual port number

**Solution 2** - Kill the process using port 3000:
```bash
# Find process using port 3000
lsof -ti:3000

# Kill it
kill -9 $(lsof -ti:3000)

# Restart dev server
npm run dev
```

---

### Issue 4: "Build failed" or TypeScript errors

**Problem**: TypeScript compilation errors

**Solution**:
These are expected until dependencies are installed. Run:
```bash
npm install
npm run dev
```

The TypeScript errors in VS Code are normal before running `npm install`.

---

### Issue 5: CSS @tailwind errors in VS Code

**Problem**: VS Code doesn't recognize Tailwind directives

**Solution**: This is just a VS Code warning, not a real error. The project will still run.

To suppress these warnings:
1. Install the Tailwind CSS IntelliSense extension
2. The `.vscode/settings.json` file already disables CSS validation

Or ignore them - they don't affect the running application.

---

### Issue 6: "React is not defined"

**Problem**: Dependencies not installed or import issues

**Solution**:
```bash
npm install
```

Then restart the dev server.

---

### Issue 7: Blank white screen in browser

**Problem**: JavaScript error or routing issue

**Solution**:
1. Open browser console (F12)
2. Check for errors
3. Common fix:
```bash
# Clear browser cache
# Or use Incognito mode

# Restart dev server
npm run dev
```

---

### Issue 8: Styles not loading / Unstyled page

**Problem**: Tailwind CSS not compiling

**Solution**:
1. Check that these files exist:
   - `tailwind.config.js`
   - `postcss.config.js`
   - `src/index.css` (with @tailwind directives)

2. Restart dev server:
```bash
npm run dev
```

3. Hard refresh browser: `Cmd + Shift + R` (macOS) or `Ctrl + Shift + R` (Windows)

---

### Issue 9: "Cannot find module 'react/jsx-runtime'"

**Problem**: React types not installed

**Solution**:
```bash
npm install --save-dev @types/react @types/react-dom
npm run dev
```

---

### Issue 10: Slow performance or lag

**Problem**: Development build is running

**Solution**: This is normal for development. For production build:
```bash
npm run build
npm run preview
```

---

## Verification Checklist

Run these checks to ensure everything is working:

### ✅ Environment Check
```bash
# Check Node.js version (should be 18+)
node --version

# Check npm version (should be 9+)
npm --version

# Check if you're in the right directory
pwd
# Should show: /Users/hemantbaghel/Desktop/college-erp
```

### ✅ Dependencies Check
```bash
# Check if node_modules exists
ls node_modules/
# Should show many folders

# Check if Tailwind is installed
ls node_modules/tailwindcss/
# Should show files
```

### ✅ Files Check
```bash
# Check if key files exist
ls -la src/
ls -la tailwind.config.js
ls -la vite.config.ts
ls -la package.json
```

### ✅ Dev Server Check
```bash
# Start dev server
npm run dev
# Should show: "ready in XXXms" and "Local: http://localhost:3000"
```

### ✅ Browser Check
1. Open http://localhost:3000
2. Should see "College ERP" logo
3. Should see sidebar with navigation
4. Should see Dashboard with KPI tiles
5. Click around - everything should be styled

---

## Clean Installation (Nuclear Option)

If nothing else works, do a complete clean install:

```bash
# Navigate to project
cd /Users/hemantbaghel/Desktop/college-erp

# Remove all generated files
rm -rf node_modules
rm -rf dist
rm -rf .vite
rm package-lock.json

# Clear npm cache
npm cache clean --force

# Reinstall everything
npm install

# Start fresh
npm run dev
```

---

## VS Code Specific Issues

### Red squiggly lines in CSS files

**Solution**: Install Tailwind CSS IntelliSense extension
1. Open VS Code Extensions (Cmd+Shift+X)
2. Search "Tailwind CSS IntelliSense"
3. Install it
4. Reload VS Code

### TypeScript errors everywhere

**Solution**: These will go away after running `npm install`

### Import errors in .tsx files

**Solution**: 
1. Close VS Code
2. Run `npm install`
3. Reopen VS Code
4. Wait for TypeScript server to start (bottom right status)

---

## Still Not Working?

### Step-by-Step Debug

1. **Check Node.js version**:
   ```bash
   node --version
   ```
   Must be v18 or higher. If lower, update Node.js.

2. **Check npm version**:
   ```bash
   npm --version
   ```
   Must be v9 or higher.

3. **Check current directory**:
   ```bash
   pwd
   ```
   Must be `/Users/hemantbaghel/Desktop/college-erp`

4. **Check package.json exists**:
   ```bash
   cat package.json
   ```
   Should show JSON with dependencies.

5. **Fresh install**:
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```

6. **Start server**:
   ```bash
   npm run dev
   ```

7. **Check browser console** (F12):
   Look for specific error messages

8. **Check terminal output**:
   Look for specific error messages

---

## Success Indicators

You know it's working when you see:

✅ Terminal shows:
```
VITE v5.0.8  ready in XXXms
➜  Local:   http://localhost:3000/
```

✅ Browser shows:
- College ERP interface
- Blue sidebar on the left
- Dashboard with KPI cards
- Charts and visualizations
- Everything is styled (not plain HTML)

✅ Console shows:
- No errors (F12 → Console tab)
- Maybe some React DevTools messages (that's fine)

---

## Performance Optimization

Once it's running, if you want better performance:

### For Development
```bash
# Regular dev server (current)
npm run dev
```

### For Production Preview
```bash
# Build optimized version
npm run build

# Preview production build
npm run preview
```

Production build is 10x smaller and faster!

---

## Getting Help

If you're still stuck:

1. **Check error messages carefully**
   - Copy the exact error
   - Google it with "vite" or "react" keywords

2. **Check GitHub Issues**
   - Similar problems might be documented

3. **Browser Console**
   - F12 → Console tab
   - Take screenshot of errors

4. **Terminal Output**
   - Copy the full error message
   - Look for the root cause (first error)

5. **File Permissions**
   ```bash
   # Check if you can write to the directory
   touch test.txt
   rm test.txt
   ```

---

## Quick Command Reference

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Check for lint errors
npm run lint

# Update all dependencies (advanced)
npm update

# Check outdated packages
npm outdated

# Clear cache
npm cache clean --force
```

---

## System Requirements

**Minimum**:
- macOS 10.15+ (Catalina or newer)
- 4GB RAM
- 500MB disk space
- Node.js 18+
- Modern browser (Chrome 90+, Firefox 88+, Safari 14+)

**Recommended**:
- macOS 12+ (Monterey or newer)
- 8GB RAM
- 1GB disk space
- Node.js 20+
- Latest Chrome or Firefox

---

## Emergency Restart

If everything seems broken:

```bash
# 1. Stop server (Ctrl+C in terminal)

# 2. Close VS Code

# 3. Clean everything
cd /Users/hemantbaghel/Desktop/college-erp
rm -rf node_modules dist .vite package-lock.json

# 4. Reinstall
npm install

# 5. Reopen VS Code
code .

# 6. Start server
npm run dev

# 7. Open browser
# http://localhost:3000
```

---

**Still having issues? Check the main SETUP.md file or create a GitHub issue with:**
- Error message
- Terminal output
- Browser console output
- Node.js version (`node --version`)
- Operating system

Good luck! 🚀
