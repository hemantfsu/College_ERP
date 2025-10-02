# Quick Test Guide - Clerk Portal

## 🚀 Quick Start

### Login Credentials:
- **Username:** `clerk`
- **Password:** `clerk123`

---

## ✅ Test Checklist (5 minutes)

### 1. Test Main Dashboard Cards (30 seconds)
Click each colored card:
- [ ] Orange "Pending Admissions" → Opens admissions modal
- [ ] Green "Today's Collection" → Opens fees modal  
- [ ] Blue "Pending Verification" → Opens verification modal
- [ ] Purple "Hostel Requests" → Opens hostel modal

### 2. Test Quick Action Buttons (30 seconds)
Click each button at top:
- [ ] "Process Admissions" → Opens admissions modal
- [ ] "Record Payment" → Opens fees modal
- [ ] "Allocate Hostel" → Opens hostel modal
- [ ] "Verify Documents" → Opens verification modal

### 3. Test Hostel Allocation (1 minute) **MAIN FIX**
1. Click purple "Hostel Requests" card
2. Find "Pending" status row (HST-001 or HST-002)
3. Click "Allocate" button
4. **✓ Should open allocation modal with student details**
5. Type room number: `A-305`
6. Click "Approve Allocation"
7. **✓ Should see green success notification**
8. **✓ Status changes to "Approved"**

### 4. Test Bulk Import (2 minutes)
1. Click "Process Admissions"
2. Click "Import File" button in blue section
3. Create CSV file with this content:
   ```
   Name,Course,Email,Phone,Percentage
   Test Student,B.Tech CSE,test@email.com,+91-9999999999,85.5
   Sample User,B.Tech ECE,sample@email.com,+91-9999999998,90.0
   ```
4. Upload the file
5. **✓ Watch progress bar fill to 100%**
6. Click "Import Applications"
7. **✓ Success notification appears**
8. **✓ New rows appear in admission table**

### 5. Test Document Verification (1 minute)
1. Click blue "Pending Verification" card
2. Find row with "Pending" status (DOC-001 or DOC-002)
3. Click "Verify" button
4. **✓ Status changes to "Verified" (green badge)**
5. **✓ Success notification appears**
6. Click "Reject" on another pending document
7. Type rejection reason in popup
8. **✓ Status changes to "Rejected" (red badge)**

---

## 🐛 If Something Doesn't Work

### Issue: Button doesn't do anything
**Fix:** Refresh the page (Ctrl+R or Cmd+R)

### Issue: Modal doesn't open
**Fix:** 
1. Open browser console (F12)
2. Look for red error messages
3. Take a screenshot and report

### Issue: Import doesn't work
**Fix:**
1. Check CSV format (must have header row)
2. No empty lines in CSV
3. All 5 columns present

### Issue: Notification doesn't appear
**Fix:** Check top-right bell icon - notification might be there

---

## 📊 Expected Results

### Working Features:
✅ All dashboard cards open modals  
✅ All quick action buttons work  
✅ Hostel allocation modal opens with full details  
✅ Bulk import processes CSV files  
✅ Document verification updates status  
✅ Attendance marking shows progress  
✅ ID card generation triggers notification  
✅ All modals show correct data  
✅ All tables display properly  
✅ Search and filter work in modals  

### Not Yet Implemented (Expected):
🟡 "Export to CSV" shows placeholder alert  
🟡 Receipt downloads (placeholder)  
🟡 Payment recording form  
🟡 Exams section  
🟡 Reports section  
🟡 Settings page  

---

## 🎯 Critical Tests (Must Pass)

### Priority 1: Hostel Allocation
**This was the main bug fix**
- Click "Allocate" button → Modal MUST open
- Student details MUST display
- Approve/Reject MUST work

### Priority 2: Bulk Import
**New feature added**
- File upload MUST accept CSV
- Progress bar MUST animate
- Applications MUST be added

### Priority 3: All Modals
**Core functionality**
- Every card MUST open its modal
- Every button MUST work
- Every table MUST display data

---

## 🔍 Quick Visual Check

### What You Should See:

**Dashboard (Top):**
- 4 large colored gradient cards (Orange, Green, Blue, Purple)
- 6 smaller white cards with colored left borders
- 4 quick action buttons (Orange, Green, Purple, Blue)

**Dashboard (Middle):**
- 2 charts (Bar chart, Pie chart)
- 2 queue sections (Admissions, Hostel requests)

**Dashboard (Bottom):**
- 2 panels (Attendance, ID Cards)
- Recent Activity feed (left)
- Notifications panel (right)

**When Modal Opens:**
- White background overlay
- Title and subtitle at top
- Statistics cards (3-4 colored boxes)
- Data table below
- Close button (X) at top-right

---

## 💡 Pro Tips

1. **Use Ctrl+Click** (Cmd+Click on Mac) to open in new tab if needed
2. **Check notifications** - bell icon at top-right shows activity
3. **Use search boxes** in modals to filter data quickly
4. **Click anywhere outside modal** to close it
5. **Look for hover effects** - buttons change color when hovering

---

## 📞 Report Issues

If you find any bugs, note:
1. Which button/card you clicked
2. What you expected to happen
3. What actually happened
4. Any error messages in console (F12)

---

**Testing Time:** ~5 minutes  
**Critical Path:** Hostel Allocation → Bulk Import → Document Verification  
**All Features:** ~15 minutes to test thoroughly
