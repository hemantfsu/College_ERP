# 🚀 How to Run SQL Migration in Supabase

## Quick Guide (5 Minutes)

---

## 📋 What This Migration Does

This SQL script will:
- ✅ Add photo columns to `students` table
- ✅ Create `student_documents` table for file tracking
- ✅ Create `admission_documents` table for admission files
- ✅ Add indexes for performance
- ✅ Set up Row Level Security (RLS) policies
- ✅ Add auto-update triggers

---

## 🎯 Step-by-Step Instructions

### **Step 1: Open Supabase Dashboard**

1. Go to: **https://supabase.com/dashboard**
2. **Login** with your account
3. **Select your project**: `college-erp` (or whatever you named it)

---

### **Step 2: Open SQL Editor**

1. Look at the **left sidebar**
2. Click on: **SQL Editor** icon (looks like `</>` or a document)
3. Or click: **SQL Editor** text

**You should see**: A SQL editor with a text area

---

### **Step 3: Copy the SQL Script**

**Option A: Copy from File**
1. Open: `/Users/hemantbaghel/Desktop/college-erp/supabase-file-storage-migration.sql`
2. Select all text (Cmd+A on Mac)
3. Copy (Cmd+C)

**Option B: Use This Button** (in VS Code)
1. Right-click on `supabase-file-storage-migration.sql` in Explorer
2. Click "Copy Path"
3. Open the file
4. Select All (Cmd+A)
5. Copy (Cmd+C)

---

### **Step 4: Paste into Supabase SQL Editor**

1. Click in the **SQL Editor text area** (big white box)
2. Clear any existing text
3. **Paste** the SQL (Cmd+V)

**You should see**: ~200 lines of SQL code starting with:
```sql
-- ================================================================
-- DATABASE SCHEMA UPDATE FOR FILE STORAGE
-- Add columns for Backblaze B2 file storage
-- Run this after the main schema is created
-- ================================================================
```

---

### **Step 5: Run the Migration**

1. Look for the **"Run"** button (usually top-right or bottom-right)
   - OR press **Cmd+Enter** (Mac) / **Ctrl+Enter** (Windows)
2. Click **"Run"**

**Wait 2-5 seconds...**

---

### **Step 6: Check for Success**

**✅ Success Looks Like:**
```
Success. No rows returned
```
Or
```
Rows affected: 0
Success
```

**✅ You might also see**: Green checkmark or "Query executed successfully"

**❌ Error Looks Like:**
```
ERROR: relation "students" does not exist
```
or
```
ERROR: syntax error at or near...
```

---

## 🎉 Verify It Worked

### **Check Tables Were Created:**

1. In Supabase Dashboard, click **"Table Editor"** (left sidebar)
2. **Look for these tables**:
   - `student_documents` ✅ (should be new)
   - `admission_documents` ✅ (should be new)
3. Click on `students` table
4. Check columns - you should see:
   - `photo_url` ✅ (new column)
   - `photo_filename` ✅ (new column)
   - `photo_uploaded_at` ✅ (new column)

---

## ❌ Troubleshooting

### **Error: "relation 'students' does not exist"**

**Problem**: Main schema not created yet

**Fix**:
1. You need to run `supabase-schema.sql` FIRST
2. Go back to SQL Editor
3. Copy content from `/Users/hemantbaghel/Desktop/college-erp/supabase-schema.sql`
4. Run it
5. THEN run this migration

---

### **Error: "column already exists"**

**Problem**: Migration already ran before

**Solution**: This is OK! It means the tables are already there. You can skip this migration.

---

### **Error: "function update_updated_at_column does not exist"**

**Problem**: Missing trigger function from main schema

**Fix**: Run the main schema first (`supabase-schema.sql`)

---

### **Error: "permission denied"**

**Problem**: You don't have admin access

**Fix**: Make sure you're logged in as the project owner

---

## 📊 What Tables Look Like After Migration

### **student_documents** table:
```
| id (uuid) | student_id | document_type | document_name | file_url | file_name | file_size | file_type | uploaded_by | uploaded_at |
|-----------|------------|---------------|---------------|----------|-----------|-----------|-----------|-------------|-------------|
| (empty rows - ready for uploads)
```

### **admission_documents** table:
```
| id (uuid) | admission_id | document_type | file_url | file_name | file_size | uploaded_at |
|-----------|--------------|---------------|----------|-----------|-----------|-------------|
| (empty rows - ready for uploads)
```

### **students** table (new columns):
```
| ... | photo_url | photo_filename | photo_uploaded_at | ...
|-----|-----------|----------------|-------------------|-----
| ... | NULL      | NULL           | NULL              | ...
```

---

## 🎯 Quick Copy-Paste Instructions

**If you just want the SQL without reading:**

1. Open: https://supabase.com/dashboard
2. Select your project
3. Click: **SQL Editor** (left sidebar)
4. Click in text area
5. Press: **Cmd+A** (select all existing text)
6. Open: `supabase-file-storage-migration.sql` in VS Code
7. Press: **Cmd+A** (select all)
8. Press: **Cmd+C** (copy)
9. Go back to Supabase SQL Editor
10. Press: **Cmd+V** (paste)
11. Click: **Run** button (or press Cmd+Enter)
12. Wait for "Success" message

**Done!** ✅

---

## 🔍 Verify Everything Works

### **Test 1: Check Tables Exist**
```sql
-- Run this in SQL Editor to verify:
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_name IN ('student_documents', 'admission_documents');
```

**Expected**: Should return 2 rows

### **Test 2: Check Students Table Columns**
```sql
-- Run this to check new columns:
SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'students' 
  AND column_name IN ('photo_url', 'photo_filename', 'photo_uploaded_at');
```

**Expected**: Should return 3 rows

### **Test 3: Check Indexes**
```sql
-- Check indexes were created:
SELECT indexname 
FROM pg_indexes 
WHERE tablename IN ('student_documents', 'admission_documents');
```

**Expected**: Should return 5 indexes

---

## 📚 What This Enables

After running this migration, you can:

1. **Upload Student Photos**
   ```typescript
   const url = await b2Storage.uploadStudentPhoto(studentId, photoFile);
   await studentService.update(studentId, { photo_url: url });
   ```

2. **Upload Student Documents**
   ```typescript
   const url = await b2Storage.uploadStudentDocument(studentId, docFile, 'aadhar');
   await documentService.create({
     student_id: studentId,
     document_type: 'aadhar',
     file_url: url,
     // ... other fields
   });
   ```

3. **Track All Documents**
   ```typescript
   const docs = await documentService.getAllForStudent(studentId);
   // Returns all documents for a student
   ```

---

## 🎉 Success Checklist

After running the migration, verify:

- [ ] No errors in SQL Editor
- [ ] `student_documents` table exists in Table Editor
- [ ] `admission_documents` table exists in Table Editor
- [ ] `students` table has `photo_url` column
- [ ] `students` table has `photo_filename` column
- [ ] `students` table has `photo_uploaded_at` column
- [ ] Can see RLS policies on tables
- [ ] Can see indexes in database

**If all checked ✅, you're done!**

---

## 💡 Pro Tips

1. **Save Your SQL**: Supabase SQL Editor has a "Save" feature to keep queries
2. **Version Control**: This file is already in your project, safe!
3. **Rollback**: If needed, you can drop these tables and re-run
4. **Testing**: Try uploading a test file after migration

---

## 🚀 Next Steps After Migration

1. **Test File Upload**:
   - Use the `FileUpload` component
   - Upload a student photo
   - Check if URL saves to database

2. **Verify B2 Integration**:
   - Make sure B2 credentials are in `.env.local`
   - Test upload to Backblaze
   - Verify file appears in B2 dashboard

3. **Test Document Tracking**:
   - Upload different document types
   - Check `student_documents` table
   - Verify all metadata is saved

---

## 📞 Need Help?

### **Still Getting Errors?**

1. **Check main schema**: Run `supabase-schema.sql` first
2. **Check permissions**: Make sure you're project owner
3. **Check existing tables**: Maybe already created?

### **Migration Successful But Not Working?**

1. **Check RLS policies**: Make sure auth is set up
2. **Check B2 credentials**: Verify `.env.local`
3. **Check file upload code**: Use the `FileUpload` component

---

## 📋 SQL Script Preview

The migration script does this:
```sql
-- 1. Add photo columns to students
ALTER TABLE students ADD COLUMN photo_url TEXT;

-- 2. Create student_documents table
CREATE TABLE student_documents (...);

-- 3. Create admission_documents table
CREATE TABLE admission_documents (...);

-- 4. Add indexes for performance
CREATE INDEX idx_student_documents_student_id ...;

-- 5. Set up Row Level Security
ALTER TABLE student_documents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Students can view their own documents" ...;

-- And more...
```

---

## ✅ Summary

**What to do:**
1. Open Supabase Dashboard
2. Go to SQL Editor
3. Copy all SQL from `supabase-file-storage-migration.sql`
4. Paste in SQL Editor
5. Click Run
6. Wait for success
7. Verify tables exist

**Time required:** 2-5 minutes

**Result:** Database ready for file uploads! 🎉

---

**You've got this!** 💪 Just copy, paste, and run!
