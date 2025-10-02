# 🚀 STEP-BY-STEP SETUP GUIDE
## Follow Each Step Exactly - Don't Skip!

---

## ✅ STEP 1: Install Node.js (5 minutes)

### **DO THIS NOW**:

1. **Click this link**: https://nodejs.org/

2. You'll see two big green buttons. **Click the LEFT one** that says:
   ```
   XX.X.X LTS
   Recommended For Most Users
   ```

3. A file will download (about 85 MB). **Wait for it to finish**.

4. **Find the downloaded file** (probably in your Downloads folder):
   - Look for: `node-vXX.X.X.pkg`
   - **Double-click it**

5. **Follow the installer**:
   - Click "Continue"
   - Click "Continue" again
   - Click "Agree"
   - Click "Install"
   - **Enter your Mac password** when asked
   - Wait for installation (2-3 minutes)
   - Click "Close"

6. **IMPORTANT**: Close your terminal and open a NEW terminal window
   - Press `Cmd + Q` to quit Terminal
   - Press `Cmd + Space` to open Spotlight
   - Type "Terminal" and press Enter

---

## ✅ STEP 2: Verify Node.js is Installed (30 seconds)

**In the NEW terminal**, type this and press Enter:

```bash
node --version
```

**You should see something like**:
```
v20.11.0
```

**Then type this and press Enter**:
```bash
npm --version
```

**You should see something like**:
```
10.2.4
```

### ✅ If you see version numbers: SUCCESS! Go to Step 3
### ❌ If you still see "command not found": 
   - Make sure you closed and reopened Terminal
   - Try restarting your Mac
   - Then try again

---

## ✅ STEP 3: Navigate to Your Project (10 seconds)

**Copy this command EXACTLY and paste into terminal**:

```bash
cd /Users/hemantbaghel/Desktop/college-erp
```

Press **Enter**

You should see your prompt change to show you're in the college-erp folder.

---

## ✅ STEP 4: Install Project Dependencies (2-3 minutes)

**Type this command and press Enter**:

```bash
npm install
```

**What you'll see**:
- Lots of text scrolling
- Progress bars
- Messages about downloading packages
- **This is normal! Wait for it to finish (2-3 minutes)**

**When it's done**, you'll see:
```
added XXX packages in XXs
```

### ✅ If you see "added XXX packages": SUCCESS! Go to Step 5
### ❌ If you see errors: Copy the error message and let me know

---

## ✅ STEP 5: Create Supabase Account (3 minutes)

1. **Open your web browser**

2. **Go to**: https://supabase.com

3. **Click "Start your project"** (green button)

4. **Sign up**:
   - Option A: Click "Continue with GitHub" (fastest)
   - Option B: Enter email and create password
   
5. **Check your email** and verify if needed

6. You'll see the Supabase dashboard

**✅ SUCCESS! Go to Step 6**

---

## ✅ STEP 6: Create Your Database Project (5 minutes)

1. **In Supabase dashboard**, click the **"New Project"** button

2. **Fill in the form**:
   
   **Organization**: 
   - If you see a dropdown, select your organization
   - If not, it will create one automatically
   
   **Project Name**:
   ```
   college-erp
   ```
   
   **Database Password**: 
   - Click the "Generate a password" button
   - **IMPORTANT**: Click the copy button to copy it
   - **SAVE IT SOMEWHERE SAFE** (paste in Notes app or TextEdit)
   
   **Region**:
   - Choose closest to you (e.g., "South Asia (Mumbai)")
   
   **Pricing Plan**:
   - Keep "Free" selected

3. **Click "Create new project"**

4. **WAIT** - You'll see a progress bar
   - This takes **2-3 minutes**
   - **DO NOT CLOSE THE BROWSER**
   - You'll see "Setting up project..." then "Building database..."

5. **When done**, you'll see your project dashboard

**✅ SUCCESS! Go to Step 7**

---

## ✅ STEP 7: Get Your API Credentials (1 minute)

1. **Look at the left sidebar** in Supabase

2. **Click the gear icon** ⚙️ at the bottom (Settings)

3. **Click "API"** in the settings menu

4. You'll see a page with your credentials

5. **Copy these TWO things**:

   **A. Project URL** (looks like this):
   ```
   https://xxxxxxxxxxxxx.supabase.co
   ```
   - Click the copy button next to it
   - **Paste it somewhere safe** (Notes app)

   **B. anon public key** (long string starting with "eyJ"):
   ```
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ...
   ```
   - Scroll down to find "anon" "public" key
   - Click the copy button next to it
   - **Paste it somewhere safe** (Notes app)

**✅ You now have both credentials! Go to Step 8**

---

## ✅ STEP 8: Update Your Environment File (2 minutes)

1. **Open Finder**

2. **Navigate to**: Desktop → college-erp

3. **Find the file**: `.env.local`
   - **Can't see it?** Press `Cmd + Shift + .` (period) to show hidden files

4. **Open it with TextEdit**:
   - Right-click on `.env.local`
   - Choose "Open With" → "TextEdit"

5. **You'll see this**:
   ```bash
   VITE_SUPABASE_URL=https://your-project.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-key-here
   
   VITE_RAZORPAY_KEY_ID=rzp_test_ROSswCGsHCVLRN
   VITE_RAZORPAY_KEY_SECRET=OpWO6VQ3qsGM3iOmVK1LE8uV
   VITE_RAZORPAY_MODE=test
   ```

6. **Replace the placeholder values**:
   
   **Replace this line**:
   ```bash
   VITE_SUPABASE_URL=https://your-project.supabase.co
   ```
   
   **With YOUR actual URL** (from Step 7):
   ```bash
   VITE_SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
   ```

   **Replace this line**:
   ```bash
   VITE_SUPABASE_ANON_KEY=your-anon-key-here
   ```
   
   **With YOUR actual key** (from Step 7):
   ```bash
   VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ...
   ```

7. **Keep the Razorpay lines unchanged**

8. **Save the file**: Press `Cmd + S`

9. **Close TextEdit**

**✅ SUCCESS! Go to Step 9**

---

## ✅ STEP 9: Create Database Tables (3 minutes)

1. **Go back to Supabase** in your browser

2. **Click "SQL Editor"** in the left sidebar (icon looks like `</>`)

3. **Click "New query"** button

4. **Now open another file**:
   - Open Finder
   - Go to: Desktop → college-erp
   - Find: `supabase-schema.sql`
   - **Open with TextEdit**

5. **Select ALL the text**:
   - Press `Cmd + A` (selects everything)

6. **Copy it**:
   - Press `Cmd + C`

7. **Go back to Supabase SQL Editor**

8. **Paste the SQL**:
   - Click in the editor window
   - Press `Cmd + V`
   - You should see lots of SQL code

9. **Run the query**:
   - Click the "Run" button (or press `Cmd + Enter`)
   - **WAIT** - it will take 10-20 seconds

10. **You should see**:
    ```
    ✅ Success. No rows returned
    ```

**✅ If you see "Success": Great! Go to Step 10**
**❌ If you see errors**: Copy the error message and let me know

---

## ✅ STEP 10: Verify Tables Were Created (1 minute)

1. **In Supabase**, click **"Table Editor"** in the left sidebar

2. **You should see 9 tables**:
   - users
   - students
   - admissions
   - fees
   - hostel_applications
   - hostel_maintenance
   - exams
   - attendance
   - notifications

3. **Click on "students"** - you should see 5 test students

4. **Click on "users"** - you should see 5 test users

**✅ If you see all the tables with data: PERFECT! Go to Step 11**

---

## ✅ STEP 11: Start Your Application (30 seconds)

1. **Go back to Terminal**

2. **Make sure you're in the project folder**:
   ```bash
   cd /Users/hemantbaghel/Desktop/college-erp
   ```

3. **Start the development server**:
   ```bash
   npm run dev
   ```

4. **You should see**:
   ```
   VITE v5.0.8  ready in XXX ms

   ➜  Local:   http://localhost:5173/
   ➜  Network: use --host to expose
   ```

**✅ If you see this: SUCCESS! Go to Step 12**

---

## ✅ STEP 12: Open the Application (10 seconds)

1. **Open your web browser**

2. **Go to**: http://localhost:5173

3. **You should see**: The College ERP homepage with:
   - Welcome banner
   - "Apply for Admission" button
   - Navigation menu

4. **Try clicking around**:
   - Click "Admissions"
   - Click "Login"
   - Explore the interface

**🎉 CONGRATULATIONS! Your College ERP is now running!**

---

## 🎓 What You Can Do Now

### Test Login

Click "Login" and try these test accounts:

**Admin Account**:
- Email: `admin@college.edu`

**Student Account**:
- Email: `student@college.edu`

**Faculty Account**:
- Email: `faculty@college.edu`

*(Note: Authentication is currently mock-based, so you can enter any password)*

---

## 📊 Explore Features

- **Dashboard**: View metrics and stats
- **Students**: See the 5 test students
- **Admissions**: View 3 pending applications
- **Fees**: Check fee records
- **Hostel**: See room allocations
- **Exams**: View exam schedules

---

## 🛑 To Stop the Application

When you're done testing:

1. **Go to Terminal**
2. **Press**: `Ctrl + C`
3. Application will stop

---

## 🚀 To Start Again Later

Just open Terminal and run:

```bash
cd /Users/hemantbaghel/Desktop/college-erp
npm run dev
```

Then open http://localhost:5173 in your browser

---

## 📋 COMPLETE CHECKLIST

Mark each as you complete it:

- [ ] Step 1: Downloaded and installed Node.js
- [ ] Step 2: Verified Node.js works (saw version numbers)
- [ ] Step 3: Navigated to project folder
- [ ] Step 4: Ran npm install (saw "added XXX packages")
- [ ] Step 5: Created Supabase account
- [ ] Step 6: Created Supabase project (waited for completion)
- [ ] Step 7: Copied Project URL and API key
- [ ] Step 8: Updated .env.local file with real credentials
- [ ] Step 9: Ran SQL in Supabase (saw "Success")
- [ ] Step 10: Verified all 9 tables exist
- [ ] Step 11: Started dev server (npm run dev)
- [ ] Step 12: Opened http://localhost:5173 in browser

**All checked?** 🎉 **YOU DID IT!**

---

## 🆘 HELP - If You Get Stuck

### Step 1 Issues:
**Problem**: Can't install Node.js
- Make sure you downloaded from nodejs.org
- Try restarting your Mac
- Make sure you're clicking the LTS version (left button)

### Step 2 Issues:
**Problem**: Still see "command not found"
- Did you close and reopen Terminal?
- Try restarting your Mac
- Make sure Node.js installer said "Success"

### Step 4 Issues:
**Problem**: npm install fails
- Make sure you're in the right folder (Step 3)
- Check your internet connection
- Try running it again

### Step 9 Issues:
**Problem**: SQL errors
- Make sure you copied ALL the SQL (Cmd+A in the file)
- Make sure you're in SQL Editor (not Table Editor)
- Try copying and pasting again

### Step 11 Issues:
**Problem**: npm run dev fails
- Make sure Step 4 completed successfully
- Make sure .env.local has real credentials (Step 8)
- Try closing terminal and opening new one

---

## 💡 Pro Tips

1. **Keep Terminal open** while app is running
2. **Don't close Supabase browser tab** - you might need it
3. **Save your credentials** - you'll need them later
4. **Check browser console** (F12) if something doesn't work
5. **Supabase free tier** is generous - don't worry about limits

---

## 🎯 Next Steps After Setup

Once everything is working:

1. **Explore the features** - click around, try everything
2. **Check the dashboards** - each role has different view
3. **View test data** - see students, admissions, fees
4. **Read documentation** - check README.md for features
5. **Start customizing** - make it your own!

---

**🚀 Ready to start? Begin with Step 1!**

**Good luck! You've got this! 💪**

---

**Created**: October 2, 2025  
**Estimated Total Time**: 20-30 minutes  
**Difficulty**: Easy (just follow the steps!)
