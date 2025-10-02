# 📱 SMS & 📂 File Storage Integration Guide

## Complete Setup for SMS Sending & Backblaze B2 Storage

---

## 🎯 What's Integrated

### ✅ SMS Service (MSG91)
- Send OTPs
- Admission notifications
- Fee reminders & confirmations
- Hostel allocation alerts
- Exam notifications
- Bulk SMS to students

### ✅ Backblaze B2 Storage
- Upload student photos
- Store documents (Aadhar, Marksheets, etc.)
- Download files
- Delete files
- Public URL access

---

## 📱 PART 1: SMS Integration Setup

### Step 1: Sign Up for MSG91 (5 minutes)

1. **Go to**: https://msg91.com

2. **Sign up** with your email

3. **Verify your email** and phone number

4. **Complete KYC** (if required for production)

### Step 2: Get MSG91 Credentials (2 minutes)

1. **Login** to MSG91 dashboard

2. **Go to**: Settings → API Keys

3. **Copy your Auth Key**: 
   ```
   Example: 123456ABCDEFGabcdefg123456
   ```

4. **Create Sender ID**:
   - Go to: Configuration → Sender ID
   - Add: `COLEGE` (6 characters, alphanumeric)
   - Submit for approval (takes 1-2 days)

5. **Get Route Number**: 
   - Route 4 = Transactional (OTP, alerts)
   - Route 1 = Promotional

### Step 3: Update Environment Variables (1 minute)

Open `.env.local` and update:

```bash
# SMS Gateway Configuration
VITE_SMS_AUTH_KEY=your-actual-msg91-auth-key-here
VITE_SMS_SENDER_ID=COLEGE
VITE_SMS_ROUTE=4
VITE_SMS_ENABLED=true
```

**Replace**:
- `your-actual-msg91-auth-key-here` with your real Auth Key
- Set `VITE_SMS_ENABLED=true` to enable SMS

### Step 4: Test SMS (2 minutes)

Run this in your application:

```typescript
import { smsService } from './services/smsService';

// Test SMS
const result = await smsService.sendSMS({
  to: '+919876543210',
  message: 'Test SMS from College ERP!',
});

console.log(result);
```

---

## 💰 MSG91 Pricing (India)

- **Test Credits**: 25 free SMS on signup
- **Production**: ₹0.15 - ₹0.25 per SMS
- **Monthly Plans**: Starting from ₹500/month

---

## 📂 PART 2: Backblaze B2 Storage Setup

### Step 1: Create Backblaze Account (5 minutes)

1. **Go to**: https://www.backblaze.com/b2/sign-up.html

2. **Sign up** with email

3. **Verify email** and complete setup

### Step 2: Create B2 Bucket (3 minutes)

1. **Login** to Backblaze dashboard

2. **Go to**: B2 Cloud Storage → Buckets

3. **Click**: "Create a Bucket"

4. **Fill in**:
   ```
   Bucket Name: college-erp-media
   Files in Bucket: Public
   Default Encryption: Disable
   Object Lock: Disable
   ```

5. **Click**: "Create a Bucket"

6. **Copy Bucket ID**: You'll need this

### Step 3: Create Application Key (2 minutes)

1. **Go to**: App Keys

2. **Click**: "Add a New Application Key"

3. **Fill in**:
   ```
   Name: college-erp-upload
   Allow access to Bucket: college-erp-media
   Type: Read and Write
   ```

4. **Click**: "Create New Key"

5. **IMPORTANT**: Copy these immediately (shown only once):
   - **keyID**: `0035abc123def456...`
   - **applicationKey**: `K0035xyz987...`

### Step 4: Get Endpoint URL (1 minute)

1. **Go to**: Buckets → college-erp-media

2. **Click**: "Bucket Settings"

3. **Find**: Endpoint URL
   ```
   Example: s3.us-west-002.backblazeb2.com
   ```

4. **Copy** the endpoint

### Step 5: Update Environment Variables (2 minutes)

Open `.env.local` and update:

```bash
# Backblaze B2 Configuration
VITE_B2_KEY_ID=0035abc123def456...
VITE_B2_APPLICATION_KEY=K0035xyz987...
VITE_B2_BUCKET_ID=abc123def456
VITE_B2_BUCKET_NAME=college-erp-media
VITE_B2_ENDPOINT=https://s3.us-west-002.backblazeb2.com
```

**Replace** with your actual values from Step 3 & 4

### Step 6: Update Database Schema (3 minutes)

1. **Go to**: Supabase → SQL Editor

2. **Open**: `supabase-file-storage-migration.sql` from your project

3. **Copy ALL** the SQL (Cmd+A, Cmd+C)

4. **Paste** into Supabase SQL Editor

5. **Click**: "Run" (Cmd+Enter)

6. **Verify**: You should see success message

7. **Check Tables**:
   - Go to Table Editor
   - You should see: `student_documents` and `admission_documents`

### Step 7: Test File Upload (2 minutes)

```typescript
import { b2Storage } from './services/b2StorageService';

// Test upload
const file = new File(['test'], 'test.txt', { type: 'text/plain' });
const result = await b2Storage.uploadStudentPhoto('student-123', file);

console.log(result);
```

---

## 💰 Backblaze B2 Pricing

- **First 10GB**: FREE forever
- **Storage**: $0.005/GB/month ($5 per TB)
- **Downloads**: First 1GB free daily, then $0.01/GB
- **Uploads**: FREE
- **API Calls**: FREE

**Comparison**:
- AWS S3: $0.023/GB/month (5x more expensive)
- B2 is 4-5x cheaper than AWS S3!

---

## 🗂️ Database Tables Created

### `student_documents`
Stores student photos and documents metadata:

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| student_id | UUID | Reference to student |
| document_type | TEXT | aadhar, marksheet, photo, etc. |
| document_name | TEXT | Display name |
| file_url | TEXT | Public URL from B2 |
| file_name | TEXT | B2 filename |
| file_size | INTEGER | Size in bytes |
| file_type | TEXT | MIME type |
| uploaded_by | UUID | Who uploaded |
| uploaded_at | TIMESTAMPTZ | When uploaded |

### `admission_documents`
Documents uploaded during admission:

| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| admission_id | UUID | Reference to admission |
| document_type | TEXT | Type of document |
| file_url | TEXT | Public URL from B2 |
| file_name | TEXT | B2 filename |
| file_size | INTEGER | Size in bytes |

---

## 🎨 Using the File Upload Component

### In Student Profile:

```typescript
import FileUpload from '../components/FileUpload';

<FileUpload
  studentId="student-uuid-here"
  uploadType="photo"
  onUploadComplete={(fileUrl, fileName) => {
    console.log('Uploaded:', fileUrl);
    // Save to database
  }}
  onUploadError={(error) => {
    console.error('Upload failed:', error);
  }}
/>
```

### For Documents:

```typescript
<FileUpload
  studentId="student-uuid-here"
  uploadType="document"
  documentType="aadhar"
  onUploadComplete={(fileUrl, fileName) => {
    // Save to student_documents table
    insertDocument(fileUrl, fileName);
  }}
/>
```

---

## 📱 SMS Service Usage Examples

### Send Admission Approval:

```typescript
import { smsService } from '../services/smsService';

await smsService.sendAdmissionApproval(
  '+919876543210',
  'Rajesh Kumar',
  'CS2024001',
  'B.Tech CSE'
);
```

### Send Fee Reminder:

```typescript
await smsService.sendFeeReminder(
  '+919876543210',
  'Rajesh Kumar',
  50000,
  '15-Oct-2025'
);
```

### Send OTP:

```typescript
const otp = Math.floor(100000 + Math.random() * 900000).toString();
await smsService.sendOTP({
  to: '+919876543210',
  otp: otp,
});
```

### Send Bulk SMS:

```typescript
const phoneNumbers = [
  '+919876543210',
  '+919876543211',
  '+919876543212',
];

await smsService.sendBulkSMS(
  phoneNumbers,
  'College will remain closed tomorrow due to holiday.'
);
```

---

## 📊 File Storage Structure in B2

```
college-erp-media/
├── students/
│   ├── {student-id}/
│   │   ├── photos/
│   │   │   └── profile_1696234567890.jpg
│   │   └── documents/
│   │       ├── aadhar_1696234567891.pdf
│   │       ├── marksheet_1696234567892.pdf
│   │       └── transfer_certificate_1696234567893.pdf
│   └── ...
└── ...
```

---

## ✅ Complete Setup Checklist

### SMS Setup:
- [ ] MSG91 account created
- [ ] Auth Key obtained
- [ ] Sender ID created (approval pending is OK)
- [ ] `.env.local` updated with MSG91 credentials
- [ ] `VITE_SMS_ENABLED=true` set
- [ ] Tested SMS sending

### B2 Storage Setup:
- [ ] Backblaze account created
- [ ] Bucket created (public)
- [ ] Application key created
- [ ] Endpoint URL obtained
- [ ] `.env.local` updated with B2 credentials
- [ ] Database migration SQL executed
- [ ] `student_documents` table exists
- [ ] `admission_documents` table exists
- [ ] Tested file upload

---

## 🧪 Testing Checklist

### Test SMS:
- [ ] Test SMS to your phone number
- [ ] OTP SMS works
- [ ] Admission approval SMS works
- [ ] Fee reminder SMS works
- [ ] Bulk SMS works

### Test File Upload:
- [ ] Upload student photo (< 5MB)
- [ ] Upload document PDF (< 10MB)
- [ ] View uploaded file URL
- [ ] Download file from URL
- [ ] File appears in B2 bucket

---

## 🚨 Troubleshooting

### SMS Not Working:

**Problem**: SMS not sending
- Check: `VITE_SMS_ENABLED=true` in `.env.local`
- Check: Auth Key is correct
- Check: Phone number format (+91XXXXXXXXXX)
- Check: MSG91 account has credits
- Check: Sender ID is approved

**Problem**: SMS shows error
- Check browser console for errors
- Check: Route number is correct (4 for transactional)
- Verify: MSG91 dashboard for failed messages

### File Upload Not Working:

**Problem**: Upload fails
- Check: All B2 credentials in `.env.local`
- Check: Bucket is set to "Public"
- Check: Application key has "Read and Write" permission
- Check: File size within limits (5MB photos, 10MB docs)

**Problem**: Can't view uploaded file
- Check: Bucket is public
- Check: File URL format is correct
- Try: Opening URL directly in browser
- Verify: File exists in B2 dashboard

**Problem**: Database error
- Check: Migration SQL was run successfully
- Verify: `student_documents` table exists
- Check: student_id is valid UUID

---

## 💡 Pro Tips

### SMS:
1. **Test Mode**: Keep `VITE_SMS_ENABLED=false` during development
2. **Credits**: Buy credits in advance for production
3. **DLT Templates**: Required in India for commercial SMS
4. **Timing**: Don't send SMS between 9 PM - 9 AM
5. **Format**: Always use +91 prefix for Indian numbers

### B2 Storage:
1. **Bucket**: Always use public buckets for student files
2. **Naming**: Use timestamp in filenames to avoid conflicts
3. **Backups**: B2 keeps file versions automatically
4. **CDN**: Use Cloudflare for faster global access
5. **Costs**: First 10GB free, extremely cheap after

---

## 📚 Files Created

| File | Purpose |
|------|---------|
| `src/services/smsService.ts` | SMS sending service |
| `src/services/b2StorageService.ts` | File storage service |
| `src/components/FileUpload.tsx` | UI component for uploads |
| `supabase-file-storage-migration.sql` | Database schema |
| `.env.local` | Updated with credentials |
| `src/vite-env.d.ts` | TypeScript types |

---

## 🎯 Next Steps

### After Setup:

1. **Add to Student Page**:
   - Add FileUpload component
   - Display uploaded photos
   - Show document list

2. **Add to Admission Page**:
   - Upload documents during admission
   - Send SMS after approval/rejection

3. **Add to Fee Page**:
   - Send SMS on payment
   - Send reminders for due payments

4. **Add to Hostel Page**:
   - Send SMS on room allocation
   - Upload hostel documents

---

## 🔐 Security Notes

### Production:
- [ ] Use environment variables (never commit credentials)
- [ ] Enable HTTPS for all uploads
- [ ] Validate file types and sizes
- [ ] Scan uploaded files for malware
- [ ] Rate limit uploads per user
- [ ] Use signed URLs for private files
- [ ] Monitor B2 usage and costs
- [ ] Set up SMS spending limits

---

## 📞 Support

### MSG91:
- Dashboard: https://control.msg91.com
- Docs: https://docs.msg91.com
- Support: support@msg91.com

### Backblaze B2:
- Dashboard: https://www.backblaze.com/b2
- Docs: https://www.backblaze.com/b2/docs/
- Support: help@backblaze.com

---

## 🎉 You're Ready!

Both services are now integrated:
- ✅ Send SMS notifications
- ✅ Upload student photos
- ✅ Store documents in B2
- ✅ Display files with public URLs

**Start using the FileUpload component and smsService in your application!**

---

**Created**: October 2, 2025  
**Updated**: October 2, 2025  
**Status**: Complete & Ready to Use 🚀
