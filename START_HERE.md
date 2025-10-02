# 🚀 START HERE - College ERP Quick Start

## Before You Begin

⚠️ **IMPORTANT**: You need Node.js installed to run this project.

### Check if Node.js is installed:
```bash
node --version
```

If you see a version number (like v18.x.x or v20.x.x), you're good! Skip to **Step 3**.

If you see "command not found", continue to Step 1.

---

## Step 1: Install Node.js (One-Time Setup)

### Option A: Using Homebrew (Recommended)
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Node.js
brew install node
```

### Option B: Direct Download
1. Go to https://nodejs.org/
2. Download the **LTS version** (left button)
3. Open the downloaded file and follow the installer
4. Restart your terminal

### Verify Installation
```bash
node --version   # Should show v18+ or v20+
npm --version    # Should show v9+ or v10+
```

---

## Step 2: Open Terminal and Navigate to Project

```bash
cd /Users/hemantbaghel/Desktop/college-erp
```

---

## Step 3: Run the Automated Setup Script

```bash
./start.sh
```

This script will:
1. ✅ Check if Node.js is installed
2. 📦 Install all dependencies automatically
3. 🚀 Start the development server
4. 🌐 Open the app (go to http://localhost:3000)

**That's it!** The script does everything for you.

---

## Manual Setup (Alternative)

If you prefer to run commands manually:

```bash
# 1. Navigate to project
cd /Users/hemantbaghel/Desktop/college-erp

# 2. Install dependencies (first time only)
npm install

# 3. Start development server
npm run dev
```

---

## Step 4: Open in Browser

Once you see this in your terminal:
```
  ➜  Local:   http://localhost:3000/
```

Open your browser and go to: **http://localhost:3000**

You should see the **College ERP Dashboard**! 🎉

---

## What You Should See

✅ **Sidebar** on the left with navigation (Dashboard, Admissions, Fees, etc.)  
✅ **KPI Cards** showing statistics  
✅ **Charts** and visualizations  
✅ **Blue and white** modern design  
✅ Everything **styled and beautiful**  

If you see plain HTML (no colors/styling), check the TROUBLESHOOTING.md file.

---

## Quick Test

Try these to verify everything works:

1. **Click "Admissions"** in the sidebar
2. **Click "New Admission"** button
3. **Fill the form** and submit
4. **See the new student** in the table

---

## Common Issues

### "npm: command not found"
→ Node.js is not installed. Go back to Step 1.

### "Port 3000 already in use"
→ No problem! Vite will use port 3001 or 3002. Check your terminal for the actual URL.

### Blank screen or errors in browser
→ Press F12 to open console and see errors, then check TROUBLESHOOTING.md

### VS Code showing red errors
→ Normal! Run `npm install` and restart VS Code. The errors will disappear.

---

## Stopping the Server

Press **Ctrl + C** in the terminal where the server is running.

---

## Next Steps

Once it's running:

1. 📖 Read **QUICK_REFERENCE.md** to learn how to use features
2. 🎬 Check **DEMO_CHECKLIST.md** for a guided tour
3. 📚 Read **README.md** for complete documentation

---

## Need Help?

Check these files in order:

1. **TROUBLESHOOTING.md** ← Most common issues solved here
2. **SETUP.md** ← Detailed setup instructions
3. **README.md** ← Complete project documentation

---

## System Requirements

- macOS 10.15+ (Catalina or newer)
- Node.js 18 or higher
- 500MB free disk space
- Modern web browser (Chrome, Firefox, Safari, Edge)

---

## Summary

```bash
# Quick start commands:
cd /Users/hemantbaghel/Desktop/college-erp
./start.sh
# Then open http://localhost:3000 in your browser
```

That's all you need! 🚀

---

**Having issues?** → Check **TROUBLESHOOTING.md**

**Want to learn more?** → Check **README.md**

**Ready to demo?** → Check **DEMO_CHECKLIST.md**

---

*Last updated: October 2025*
