# 🚀 Complete Installation Guide - College ERP

## ⚠️ Prerequisites Installation Required

Your system needs Node.js and npm to run this application. Follow these steps:

---

## Step 1: Install Node.js and npm

### Option A: Using Homebrew (Recommended for macOS)

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Node.js** (includes npm):
   ```bash
   brew install node
   ```

3. **Verify installation**:
   ```bash
   node --version
   npm --version
   ```
   You should see version numbers like:
   ```
   v20.x.x
   10.x.x
   ```

### Option B: Download from Official Website

1. Go to [nodejs.org](https://nodejs.org/)
2. Download the **LTS version** (Long Term Support)
3. Run the installer
4. Follow installation wizard
5. Restart your terminal
6. Verify installation:
   ```bash
   node --version
   npm --version
   ```

---

## Step 2: Install Project Dependencies

Once Node.js is installed:

```bash
cd /Users/hemantbaghel/Desktop/college-erp
npm install
```

This will install all required packages including:
- React
- TypeScript
- Vite
- React Router
- Tailwind CSS
- And more...

---

## Step 3: Install Supabase Client

```bash
npm install @supabase/supabase-js
```

---

## Step 4: Setup Supabase Database

### 4.1 Create Supabase Project

1. Go to [supabase.com](https://supabase.com)
2. Sign in or create account
3. Click **"New Project"**
4. Fill in:
   - **Name**: `college-erp`
   - **Database Password**: (create strong password - save it!)
   - **Region**: Choose closest to you
5. Click **"Create new project"**
6. Wait 2-3 minutes for setup

### 4.2 Get API Credentials

1. In Supabase dashboard, go to **Settings** ⚙️ → **API**
2. Copy these values:
   - **Project URL**: `https://xxxxxxxxxxxxx.supabase.co`
   - **anon/public key**: `eyJhbG....` (long string)

### 4.3 Update Environment Variables

1. Open `.env.local` in your project
2. Replace the placeholder values:

```bash
# Replace with your actual Supabase credentials
VITE_SUPABASE_URL=https://your-actual-project-url.supabase.co
VITE_SUPABASE_ANON_KEY=your-actual-anon-key-here

# Keep existing Razorpay config
VITE_RAZORPAY_KEY_ID=rzp_test_ROSswCGsHCVLRN
VITE_RAZORPAY_KEY_SECRET=OpWO6VQ3qsGM3iOmVK1LE8uV
VITE_RAZORPAY_MODE=test
```

### 4.4 Create Database Tables

1. In Supabase dashboard, go to **SQL Editor**
2. Click **"New query"**
3. Open the file `supabase-schema.sql` from your project
4. Copy **ALL** content (Cmd+A, Cmd+C)
5. Paste into SQL Editor (Cmd+V)
6. Click **"Run"** or press `Cmd+Enter`
7. Wait for: ✅ **Success. No rows returned**

### 4.5 Verify Tables

1. Go to **Table Editor** in Supabase
2. You should see 9 tables:
   - ✅ users
   - ✅ students
   - ✅ admissions
   - ✅ fees
   - ✅ hostel_applications
   - ✅ hostel_maintenance
   - ✅ exams
   - ✅ attendance
   - ✅ notifications

---

## Step 5: Run Development Server

```bash
cd /Users/hemantbaghel/Desktop/college-erp
npm run dev
```

The application should open at `http://localhost:5173`

---

## 📋 Complete Installation Checklist

- [ ] Node.js installed (v16 or higher)
- [ ] npm installed (comes with Node.js)
- [ ] Project dependencies installed (`npm install`)
- [ ] Supabase package installed (`npm install @supabase/supabase-js`)
- [ ] Supabase project created
- [ ] API credentials obtained
- [ ] `.env.local` updated with real credentials
- [ ] Database schema executed (SQL ran successfully)
- [ ] All 9 tables visible in Supabase
- [ ] Development server running (`npm run dev`)
- [ ] Application opens in browser

---

## 🚨 Troubleshooting

### Issue: "command not found: npm"

**Solution**: Node.js is not installed. Follow Step 1 above.

### Issue: "npm install" fails

**Solution**:
```bash
# Clear npm cache
npm cache clean --force

# Try again
npm install
```

### Issue: "Cannot find module '@supabase/supabase-js'"

**Solution**:
```bash
npm install @supabase/supabase-js
```

### Issue: "Missing Supabase environment variables"

**Solution**:
- Check `.env.local` file exists
- Verify credentials are correct (no placeholders)
- Restart dev server: `npm run dev`

### Issue: Port 5173 already in use

**Solution**:
```bash
# Kill process on port 5173
lsof -ti:5173 | xargs kill -9

# Or use different port
npm run dev -- --port 3000
```

---

## 🎯 Quick Start Commands

```bash
# Navigate to project
cd /Users/hemantbaghel/Desktop/college-erp

# Install all dependencies
npm install

# Install Supabase
npm install @supabase/supabase-js

# Run development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

---

## 📚 What's Next?

After successful installation:

1. ✅ **Login to the application**
   - Default admin credentials in test data
   - Email: `admin@college.edu`

2. ✅ **Test features**
   - Dashboard metrics
   - Student management
   - Admission workflow
   - Fee management
   - Hostel portal
   - Exam scheduling

3. ✅ **Create your own data**
   - Add real students
   - Process admissions
   - Manage fees and hostel

4. ✅ **Customize**
   - Update college name
   - Add courses
   - Configure settings

---

## 🔐 Security Notes

- Never commit `.env.local` to Git
- Keep Supabase keys secure
- Change default passwords
- Enable RLS policies (already done in SQL)
- Use strong database password

---

## 📞 Support

**Documentation Files**:
- `README.md` - Project overview
- `SUPABASE_QUICK_START.md` - Supabase setup guide
- `SUPABASE_INTEGRATION_SUMMARY.md` - Integration overview
- `supabase-schema.sql` - Database schema

**Resources**:
- Supabase Docs: https://supabase.com/docs
- React Docs: https://react.dev
- Vite Docs: https://vitejs.dev

---

## ✅ Installation Status

Current status based on your system:

- ❌ Node.js - **NOT INSTALLED** (Required)
- ❌ npm - **NOT INSTALLED** (Comes with Node.js)
- ⏳ Project dependencies - **PENDING** (Need npm first)
- ⏳ Supabase client - **PENDING** (Need npm first)
- ✅ Supabase SQL schema - **READY** (in supabase-schema.sql)
- ⏳ Database setup - **PENDING** (Need to run SQL)
- ⏳ Development server - **PENDING** (Need npm first)

---

## 🎯 Your Next Steps

### RIGHT NOW:

1. **Install Node.js**:
   ```bash
   brew install node
   ```
   Or download from nodejs.org

2. **Verify installation**:
   ```bash
   node --version
   npm --version
   ```

3. **Install project dependencies**:
   ```bash
   cd /Users/hemantbaghel/Desktop/college-erp
   npm install
   ```

4. **Install Supabase**:
   ```bash
   npm install @supabase/supabase-js
   ```

5. **Setup Supabase** (follow Step 4 above)

6. **Run the app**:
   ```bash
   npm run dev
   ```

---

**Total Setup Time**: ~20 minutes (including Node.js installation)

**Ready to start! 🚀**
