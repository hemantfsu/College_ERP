# Quick Reference - Bulk Import

## 🚀 How to Use Bulk Import

### Step 1: Download Template
1. Go to Admissions page
2. Click **"Bulk Import"** button (top right)
3. Click **"Download CSV Template"**
4. Template file downloads: `student-import-template.csv`

### Step 2: Prepare Your Data
Open the template in Excel/Google Sheets and fill in:
- **firstName** - Student's first name
- **lastName** - Student's last name
- **dob** - Birth date (format: 2000-01-15)
- **aadhaar** - 12-digit number
- **email** - Email address
- **phone** - Format: +91-9876543210
- **course** - Full course name
- **feeBalance** - Initial balance (usually 0)

### Step 3: Save as CSV
- File → Save As → CSV format
- Name it: `students.csv` (or any name)

### Step 4: Upload and Import
1. Click **"Choose CSV File"**
2. Select your CSV file
3. **Review the preview** - check all data is correct
4. Click **"Import X Students"** button
5. Success! Students are imported

---

## ✅ CSV Template Example

```csv
firstName,lastName,dob,aadhaar,email,phone,course,feeBalance
Rajesh,Kumar,2000-05-10,123456789012,rajesh@email.com,+91-9876543210,BSc Computer Science,0
Priya,Sharma,2001-08-15,234567890123,priya@email.com,+91-9876543211,BA English Literature,0
Amit,Patel,2000-12-20,345678901234,amit@email.com,+91-9876543212,BCom Accounting,0
```

---

## ⚠️ Common Errors

### Error: "Missing required columns"
**Fix:** Make sure your CSV has all 8 columns exactly as shown in template

### Error: "CSV file must contain at least one student"
**Fix:** Add at least one student row below the headers

### Error: "Error parsing CSV file"
**Fix:** 
- Make sure file is saved as CSV (not Excel)
- No extra commas in data
- Use plain text editor if issues persist

---

## 💡 Pro Tips

1. **Use the template** - Don't create CSV from scratch
2. **Test with 2-3 students first** - Verify format works
3. **Check preview carefully** - Easier to fix before import
4. **Date format matters** - Use YYYY-MM-DD (2000-01-15)
5. **Phone needs +91** - Include country code
6. **Refresh after import** - Data persists in localStorage

---

## 📊 What Happens During Import?

- ✅ Each student gets unique ID: `COL2025-XXXX`
- ✅ Admission date set to today
- ✅ Status set to "Active"
- ✅ Audit trail created ("bulk-imported")
- ✅ Saved to localStorage automatically
- ✅ Appears in students list immediately

---

## 🎯 Time Savings

**Manual Entry:**  
50 students × 5 minutes = 250 minutes (4 hours!)

**Bulk Import:**  
50 students = 10 minutes total

**You save 240 minutes!** ⏱️

---

*Need help? Check BULK_IMPORT_FEATURE.md for full documentation*
