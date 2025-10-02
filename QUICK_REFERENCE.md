# Quick Reference Guide - College ERP

## 🚀 Getting Started

### First Time Setup
1. Install Node.js (v18+): https://nodejs.org/
2. Open terminal and navigate to project:
   ```bash
   cd /Users/hemantbaghel/Desktop/college-erp
   ```
3. Install dependencies:
   ```bash
   npm install
   ```
4. Start the application:
   ```bash
   npm run dev
   ```
5. Open browser to http://localhost:3000

### Daily Usage
```bash
npm run dev        # Start development server
npm run build      # Build for production
npm run preview    # Preview production build
npm run lint       # Check code quality
```

## 📋 Common Tasks

### Add a New Student
1. Navigate to **Admissions** page
2. Click **"New Admission"** button
3. Fill required fields:
   - First Name *
   - Last Name *
   - Date of Birth *
   - Aadhaar Number * (12 digits)
   - Email *
   - Phone * (format: +91-XXXXXXXXXX)
   - Course *
4. Press **Enter** or click **"Admit Student"**
5. Student appears in the table with auto-generated ID

### Process a Payment
1. Navigate to **Fees** page
2. Select student from dropdown
3. View outstanding balance
4. Enter payment amount
5. Choose payment method (Cash/Card/UPI/Bank Transfer)
6. Click **"Process Payment"**
7. Receipt PDF downloads automatically
8. Balance updates in student record

### Allocate Hostel Room
1. Navigate to **Hostel** page
2. View room occupancy grid
3. Click on available room (green)
4. Select student to allocate
5. Confirm allocation
6. Room status updates to occupied (yellow)

### Create an Exam
1. Navigate to **Exams** page
2. Click **"Create Exam"** button
3. Enter exam details:
   - Name
   - Course
   - Date
   - Subjects
4. Save exam
5. Exam appears as "Draft"

### Upload Marks (Planned)
1. Select exam from list
2. Click **"Upload Marks"**
3. Upload CSV file with format:
   ```csv
   Student ID, Subject 1, Subject 2, Subject 3
   COL2025-0001, 85, 90, 78
   ```
4. Preview and validate
5. Confirm upload

### View Student Profile
1. Navigate to **Students** page
2. Find student in table
3. Click **"View"** button
4. See tabs:
   - Personal info
   - Fee history
   - Hostel allocation
   - Exam results
   - Documents
   - Audit trail

### Switch Roles (Demo)
1. Navigate to **Settings** page
2. Scroll to "Role Switcher"
3. Click desired role button:
   - Admin (full access)
   - Clerk (admissions)
   - Fee Collector (payments)
   - Hostel Warden (rooms)
   - Exam Officer (exams)
   - Registrar (reports)
4. UI updates based on permissions

### Export Data
1. Navigate to **Students** page
2. Click **"Export CSV"** button
3. File downloads with all student data
4. Open in Excel/Sheets

## ⌨️ Keyboard Shortcuts

### Global
- `Ctrl/Cmd + K` - Focus search bar
- `Esc` - Close modal/dialog
- `Tab` - Navigate between fields
- `Enter` - Submit form

### Forms
- `Tab` - Next field
- `Shift + Tab` - Previous field
- `Enter` - Submit (if valid)
- `Esc` - Cancel/close

## 🎨 UI Components Reference

### Buttons
```tsx
<button className="btn btn-primary">Primary Action</button>
<button className="btn btn-secondary">Secondary Action</button>
<button className="btn btn-success">Success Action</button>
```

### Cards
```tsx
<div className="card">
  <h3 className="text-lg font-semibold mb-4">Card Title</h3>
  <p>Card content</p>
</div>
```

### Form Fields
```tsx
<div>
  <label className="label">Field Name</label>
  <input type="text" className="input" />
</div>
```

### Status Badges
```tsx
<span className="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">
  Active
</span>
```

## 📊 Data Formats

### Student ID
Format: `COL2025-XXXX`
Example: `COL2025-0001`

### Receipt Number
Format: `REC-2025-XXXXX`
Example: `REC-2025-00001`

### Payment ID
Format: `PAY-2025-XXXX`
Example: `PAY-2025-0001`

### Phone Number
Format: `+91-XXXXXXXXXX`
Example: `+91-9876543210`

### Date Format
Format: `YYYY-MM-DD`
Example: `2025-10-02`

## 🔍 Search Tips

### Global Search (Top Bar)
- Search by student name
- Search by student ID
- Search by phone number
- Search by Aadhaar number
- Results update in real-time

### Table Filters
- Use column headers to sort
- Use search box for quick filter
- Click row to view details

## 💡 Pro Tips

### Performance
- Use keyboard navigation for faster data entry
- Keep browser console open to see any errors
- Clear localStorage if data gets corrupted:
  ```javascript
  localStorage.clear()
  ```

### Data Entry
- Tab through admission form for speed
- Copy/paste Aadhaar numbers to avoid typos
- Use dropdown selectors instead of typing course names
- Payment method buttons are faster than dropdowns

### Troubleshooting
- Refresh page if UI freezes
- Check browser console (F12) for errors
- Verify localStorage has data:
  ```javascript
  localStorage.getItem('students')
  ```
- Clear cache if styles don't load

## 🛠️ Developer Tips

### Add Custom Colors
Edit `tailwind.config.js`:
```javascript
colors: {
  custom: '#yourcolor'
}
```

### Add New Route
1. Create page component in `src/pages/`
2. Add route in `src/App.tsx`:
   ```tsx
   <Route path="/newpage" element={<NewPage />} />
   ```
3. Add nav link in `Layout.tsx`

### Access Global State
```tsx
import { useApp } from '../contexts/AppContext';

function Component() {
  const { students, addStudent } = useApp();
  // Use state
}
```

### Generate Mock Data
```typescript
const mockStudent = {
  studentId: `COL2025-${String(count).padStart(4, '0')}`,
  firstName: 'Test',
  lastName: 'User',
  // ... other fields
};
```

## 🐛 Common Issues & Solutions

### Issue: npm not found
**Solution**: Install Node.js from https://nodejs.org/

### Issue: Port 3000 already in use
**Solution**: Vite will use next available port automatically (3001, 3002)

### Issue: Build fails
**Solution**:
```bash
rm -rf node_modules package-lock.json
npm install
```

### Issue: Styles not loading
**Solution**: Ensure Tailwind CSS is properly configured and PostCSS is running

### Issue: Data not persisting
**Solution**: Check browser localStorage is enabled and not full

### Issue: PDF not generating
**Solution**: Check jsPDF is imported correctly and student data is complete

## 📱 Mobile Usage

### Responsive Breakpoints
- `sm`: 640px (phone landscape)
- `md`: 768px (tablet)
- `lg`: 1024px (laptop)
- `xl`: 1280px (desktop)

### Mobile Optimizations
- Sidebar collapses to hamburger menu
- Tables scroll horizontally
- Cards stack vertically
- Touch-friendly button sizes (44x44px minimum)

## 🔐 Security Best Practices

### Data Handling
- Never expose Aadhaar numbers fully in UI
- Mask sensitive information
- Log all data modifications
- Implement role-based access

### Production Deployment
- Enable HTTPS
- Set up CORS properly
- Use environment variables for API keys
- Implement rate limiting
- Add authentication/authorization

## 📞 Quick Links

- Main Documentation: `README.md`
- Setup Guide: `SETUP.md`
- Project Structure: `STRUCTURE.md`
- This Guide: `QUICK_REFERENCE.md`

## 📈 Performance Benchmarks

### Expected Load Times
- Initial page load: < 2 seconds
- Route navigation: < 200ms
- Form submission: < 500ms
- PDF generation: < 1 second
- Search results: < 100ms

### Browser Support
- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

---

**Need Help?** Check console for errors or refer to detailed documentation in README.md

**Last Updated**: October 2025
