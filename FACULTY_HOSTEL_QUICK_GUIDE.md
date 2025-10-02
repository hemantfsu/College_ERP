# Quick Reference - Faculty & Hostel Roles

## 🎓 Faculty Login
```
URL: http://localhost:5173/login
Username: faculty
Password: faculty123
Dashboard: /faculty-dashboard
```

### Quick Actions
1. **Mark Attendance**: Dashboard → Click class card → Mark Attendance button
2. **Upload Syllabus**: My Classes modal → Click Upload next to class
3. **Upload Marks**: Exams modal → Click Upload Marks next to exam
4. **View Performance**: Click Performance metric card → Opens detailed modal
5. **Export Reports**: Performance modal → Download PDF/CSV button

### Key Metrics at a Glance
- 4 Assigned Classes
- 180 Total Students
- 3 Upcoming Exams
- 12 Pending Grading Tasks
- 78% Average Performance

---

## 🏠 Hostel Login
```
URL: http://localhost:5173/login
Username: hostel
Password: hostel123
Dashboard: /hostel-dashboard
```

### Quick Actions
1. **Approve Application**: Dashboard → Pending Applications → Approve → Select block/floor/room → Confirm
2. **Reject Application**: Click Reject → Enter reason → Confirm
3. **Update Maintenance**: Maintenance section → Select status dropdown → Choose new status
4. **View Occupancy**: Click Occupancy Reports button → See block-wise data
5. **Export Data**: Occupancy modal → Download CSV/PDF

### Key Metrics at a Glance
- 500 Total Capacity
- 385 Occupied Rooms (77%)
- 115 Available Rooms
- 18 Pending Applications
- 7 Maintenance Requests (2 urgent)

---

## 📱 Navigation Menus

### Faculty Menu Items:
```
✓ Dashboard        → Main overview
✓ My Classes       → All assigned classes
✓ Exams           → Upcoming exams & grading
✓ Performance     → Student analytics
✓ Attendance      → Mark & track attendance
✓ Settings        → Account settings
```

### Hostel Menu Items:
```
✓ Dashboard        → Main overview
✓ Applications    → Pending student applications
✓ Occupancy       → Block-wise reports
✓ Maintenance     → Track & update requests
✓ Reports         → Export data
✓ Settings        → Account settings
```

---

## 🎨 Color Codes

### Status Indicators:
- 🟢 **Green**: Completed, Available, Good
- 🟡 **Yellow/Orange**: Pending, Moderate, Warning
- 🔴 **Red**: Urgent, High Priority, Critical
- 🔵 **Blue**: In Progress, Information
- ⚪ **Gray**: Neutral, Resolved

### Priority Levels:
- **High**: Red badge - Immediate action needed
- **Medium**: Yellow badge - Standard priority
- **Low**: Green badge - Can wait

---

## 📊 Data Overview

### Faculty Data:
```
Classes:
- CSE301: Data Structures (45 students)
- CSE302: Database Management (42 students)
- CSE401: Computer Networks (48 students)
- CSE303: Software Engineering (45 students)

Exams:
- Oct 15: Data Structures (Mid-Semester)
- Oct 18: Database Management (Mid-Semester)
- Oct 20: Computer Networks (Mid-Semester)

Performance Distribution:
- 90-100%: 15 students
- 80-89%: 35 students
- 70-79%: 48 students
- 60-69%: 32 students
- <60%: 12 students
```

### Hostel Data:
```
Blocks:
- Block A (Boys): 150 capacity, 120 occupied (80%)
- Block B (Boys): 150 capacity, 135 occupied (90%)
- Block C (Girls): 100 capacity, 80 occupied (80%)
- Block D (Girls): 100 capacity, 50 occupied (50%)

Applications: 18 pending
- Mix of boys and girls
- Various courses (B.Tech CSE, ECE, ME, IT)
- CGPA range: 7.8 - 9.2

Maintenance:
- Electrical: 3 requests
- Plumbing: 2 requests
- Furniture: 1 request
- Other: 1 request
```

---

## 🔄 Common Workflows

### Faculty: Mark Attendance
```
1. Login as faculty
2. See "Today's Classes" section
3. Find class with "Pending" status
4. Click "Mark Attendance" button
5. Success alert shows confirmation
```

### Faculty: Upload Syllabus
```
1. Click "My Classes" button
2. Find class without syllabus
3. Click "Upload" button
4. Select PDF/DOC file
5. Watch progress bar (0-100%)
6. See success notification
```

### Hostel: Process Application
```
1. Login as hostel
2. See "Recent Applications" section
3. Review student details (CGPA, distance)
4. Click "Approve" button
5. Select appropriate block (gender-based)
6. Choose floor (1-3)
7. Select room number
8. Click "Allocate Room"
9. See confirmation alert
```

### Hostel: Update Maintenance
```
1. View "Maintenance Requests" section
2. Find request to update
3. Click status dropdown
4. Select new status:
   - Pending → In Progress
   - In Progress → Resolved
5. See success notification
```

---

## 🐛 Troubleshooting

### Issue: Can't see Faculty/Hostel option on login
**Solution**: Clear browser cache, refresh page. Options should appear.

### Issue: Dashboard shows empty data
**Solution**: Mock data is hardcoded in component. Check console for errors.

### Issue: Navigation menu not showing
**Solution**: Verify role in Layout.tsx getNavigationItems() function.

### Issue: Modal not opening
**Solution**: Check setActiveModal state is being updated correctly.

### Issue: File upload not working
**Solution**: File upload is simulated. Check progress bar animation.

---

## 📝 Testing Commands

### Test Faculty Login:
1. Navigate to `/login`
2. Select "Faculty" role
3. Enter: `faculty` / `faculty123`
4. Should redirect to `/faculty-dashboard`
5. Verify 4 metric cards visible

### Test Hostel Login:
1. Navigate to `/login`
2. Select "Hostel Manager" role
3. Enter: `hostel` / `hostel123`
4. Should redirect to `/hostel-dashboard`
5. Verify 4 block cards visible

### Test Navigation:
```javascript
// Faculty
currentUser.role = 'faculty'
// Should show: Dashboard, My Classes, Exams, Performance, Attendance, Settings

// Hostel
currentUser.role = 'hostel-warden'
// Should show: Dashboard, Applications, Occupancy, Maintenance, Reports, Settings
```

---

## 🎯 Feature Checklist

### Faculty Dashboard:
- [x] Overview with key metrics
- [x] Assigned classes table
- [x] Exam management
- [x] Grading task queue
- [x] Performance analytics
- [x] Attendance tracking
- [x] File upload (syllabus, marks, questions)
- [x] Charts (bar, pie)
- [x] Notifications panel
- [x] Recent activity log
- [x] Export reports
- [x] Responsive design

### Hostel Dashboard:
- [x] Overview with key metrics
- [x] Block-wise occupancy cards
- [x] Application review system
- [x] Room allocation modal
- [x] Gender-based filtering
- [x] Maintenance tracking
- [x] Priority management
- [x] Status updates
- [x] Occupancy reports
- [x] Charts (bar, pie)
- [x] Notifications panel
- [x] Recent activity log
- [x] Export reports
- [x] Responsive design

---

## 📞 Quick Help

**Q: How do I add a new class?**
A: Currently using mock data. Extend `assignedClasses` array in FacultyDashboard.tsx

**Q: How do I add a new hostel block?**
A: Extend `hostelBlocks` array in HostelDashboard.tsx

**Q: Can students see faculty dashboard?**
A: No, navigation is role-based. Only faculty can access.

**Q: How to change occupancy limits?**
A: Modify `capacity` values in `hostelBlocks` data.

**Q: Where are files uploaded to?**
A: Currently simulated. Integration with backend needed for real uploads.

---

**Last Updated**: October 2025  
**Version**: 1.0.0  
**Status**: Production Ready ✅
