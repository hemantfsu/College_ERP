# 🏠 Hostel Portal - Quick Visual Guide

## Dashboard Layout

```
┌─────────────────────────────────────────────────────────────────────┐
│  Hostel Management Dashboard - Warden Name                          │
│  Manage hostel allocations, maintenance, and occupancy              │
│                                                                      │
│  [📄 Pending Applications (18)] [🏢 Occupancy Reports]              │
│  [🔧 Maintenance (7)] [👥 Allocated Students]                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌───────────┐ │
│  │🏢 Total     │  │🛏️  Occupied │  │📄 Pending   │  │🔧 Maint.  │ │
│  │   Capacity  │  │    Rooms    │  │    Apps     │  │  Requests │ │
│  │     500     │  │     385     │  │     18      │  │      7    │ │
│  │  77% full   │  │ 115 avail.  │  │   Review    │  │  2 urgent │ │
│  └─────────────┘  └─────────────┘  └─────────────┘  └───────────┘ │
│                                                                      │
│  ┌─ Block A (Boys) ─┐ ┌─ Block B (Boys) ─┐ ┌─ Block C (Girls)─┐  │
│  │ Capacity: 150    │ │ Capacity: 150    │ │ Capacity: 100   │  │
│  │ Occupied: 120 ✅ │ │ Occupied: 135 ⚠️ │ │ Occupied: 80 ✅ │  │
│  │ Available: 30    │ │ Available: 15    │ │ Available: 20   │  │
│  │ [████████░░] 80% │ │ [█████████░] 90% │ │ [████████░░] 80%│  │
│  └──────────────────┘ └──────────────────┘ └─────────────────┘  │
│                                                                      │
│  [Bar Chart: Occupancy]    [Pie Chart: Maintenance]                │
│                                                                      │
│  Recent Activity:                                                   │
│  ✅ Room allocated - Amit Kumar → B-304 (2 hours ago)              │
│  🔧 Maintenance resolved - A-101 (4 hours ago)                     │
│  📄 New application - Vikram Singh (6 hours ago)                   │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 1. Applications Modal

```
┌───────────────────────────────────────────────────────────────┐
│  Hostel Applications                    18 pending            │
│  ┌─ Search ────┐  ┌─ Filter ──────┐                          │
│  │ 🔍          │  │ All Statuses ▼│                          │
│  └─────────────┘  └────────────────┘                          │
├───────────────────────────────────────────────────────────────┤
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐            │
│  │ Total: 18   │ │ Approved: 3 │ │ Rejected: 1 │            │
│  └─────────────┘ └─────────────┘ └─────────────┘            │
│                                                                │
│  ┌─ Student ─────┬─ ID ────┬─ Course ──┬─ CGPA ┬─ Action ─┐│
│  │ Amit Kumar    │ STU-001 │ B.Tech CSE│  8.5  │ [Reject] ││
│  │ Male          │         │ Sem 3rd   │       │ [Approve]││
│  ├───────────────┼─────────┼───────────┼───────┼──────────┤│
│  │ Priya Sharma  │ STU-002 │ B.Tech ECE│  9.2  │ [Reject] ││
│  │ Female        │         │ Sem 5th   │       │ [Approve]││
│  ├───────────────┼─────────┼───────────┼───────┼──────────┤│
│  │ Rahul Verma   │ STU-003 │ B.Tech ME │  7.8  │ [Reject] ││
│  │ Male          │         │ Sem 1st   │       │ [Approve]││
│  └───────────────┴─────────┴───────────┴───────┴──────────┘│
│                                                                │
│  [Close]                                                       │
└───────────────────────────────────────────────────────────────┘
```

**Click "Approve" →**

```
┌───────────────────────────────────────────────────────┐
│  ✅ Allocate Room                                [X]  │
│  Amit Kumar - STU-001                                 │
├───────────────────────────────────────────────────────┤
│                                                        │
│  Student Details:                                     │
│  ┌──────────────────────────────────────────────────┐│
│  │ Course: B.Tech CSE    │ Semester: 3rd           ││
│  │ Gender: Male          │ CGPA: 8.5               ││
│  └──────────────────────────────────────────────────┘│
│                                                        │
│  Select Room:                                         │
│  ┌─ Block ───────┐ ┌─ Floor ──┐ ┌─ Room ───┐       │
│  │ Block A      ▼│ │ Floor 2 ▼│ │ Room 05 ▼│       │
│  │ (30 avail)    │ │          │ │          │       │
│  └───────────────┘ └──────────┘ └──────────┘       │
│                                                        │
│  ✓ Room A-05 on Floor 2 will be allocated            │
│                                                        │
│  [Cancel]                      [Allocate Room]        │
└───────────────────────────────────────────────────────┘
```

---

## 2. Occupancy Modal

```
┌───────────────────────────────────────────────────────────────┐
│  Occupancy Reports                                            │
│  Block-wise occupancy and availability                        │
│                                            [📥 Export Report] │
├───────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐ ┌─────────────────┐                     │
│  │ Total Capacity  │ │ Occupancy Rate  │                     │
│  │      500        │ │       77%       │                     │
│  │  All blocks     │ │   385/500       │                     │
│  └─────────────────┘ └─────────────────┘                     │
│                                                                │
│  ┌─ Block ┬ Gender ┬ Capacity ┬ Occupied ┬ Available ┬ % ──┐│
│  │ Block A│ Boys   │   150    │   120    │    30     │ 80% ││
│  │        │        │          │          │           │████░ ││
│  ├────────┼────────┼──────────┼──────────┼───────────┼─────┤│
│  │ Block B│ Boys   │   150    │   135    │    15     │ 90% ││
│  │        │        │          │          │           │█████ ││
│  ├────────┼────────┼──────────┼──────────┼───────────┼─────┤│
│  │ Block C│ Girls  │   100    │    80    │    20     │ 80% ││
│  │        │        │          │          │           │████░ ││
│  ├────────┼────────┼──────────┼──────────┼───────────┼─────┤│
│  │ Block D│ Girls  │   100    │    50    │    50     │ 50% ││
│  │        │        │          │          │           │███░░ ││
│  └────────┴────────┴──────────┴──────────┴───────────┴─────┘│
│                                                                │
│  [Bar Chart showing Occupied vs Available by Block]          │
│                                                                │
│  [Close]                                                       │
└───────────────────────────────────────────────────────────────┘
```

---

## 3. Maintenance Modal

```
┌───────────────────────────────────────────────────────────────┐
│  Maintenance Requests                       5 active          │
│  ┌─ Filter ──────────┐                                        │
│  │ All Statuses     ▼│                                        │
│  └───────────────────┘                                        │
├───────────────────────────────────────────────────────────────┤
│  ┌─────────┐ ┌─────────┐ ┌───────────┐ ┌──────────┐         │
│  │ Total:7 │ │Pending:2│ │In Prog.: 3│ │Resolved:2│         │
│  └─────────┘ └─────────┘ └───────────┘ └──────────┘         │
│                                                                │
│  ┌─ ID ────┬─ Room ──┬─ Issue ────┬ Priority ┬ Status ────┐│
│  │ MNT-001 │ A-205   │ Plumbing   │ 🔴 High  │ Pending    ││
│  │         │ Block A │ Water leak │          │ [Update ▼] ││
│  ├─────────┼─────────┼────────────┼──────────┼────────────┤│
│  │ MNT-002 │ B-310   │ Electrical │ 🟡 Medium│ In Progress││
│  │         │ Block B │ Fan broken │          │ [Update ▼] ││
│  ├─────────┼─────────┼────────────┼──────────┼────────────┤│
│  │ MNT-003 │ C-105   │ Furniture  │ 🟢 Low   │ Pending    ││
│  │         │ Block C │ Broken chr │          │ [Update ▼] ││
│  ├─────────┼─────────┼────────────┼──────────┼────────────┤│
│  │ MNT-004 │ A-101   │ Electrical │ 🔴 High  │ ✅Resolved││
│  │         │ Block A │ Socket fix │          │            ││
│  └─────────┴─────────┴────────────┴──────────┴────────────┘│
│                                                                │
│  [Close]                                                       │
└───────────────────────────────────────────────────────────────┘
```

**Click "Update" dropdown →**

```
┌─ Update Status ─┐
│ In Progress     │
│ Resolved        │
└─────────────────┘
```

**After selecting →**

```
┌─────────────────────────────────────┐
│  ✅ Status Updated!                 │
│                                     │
│  Request ID: MNT-001                │
│  New Status: In Progress            │
│                                     │
│  Notification sent to concerned     │
│  parties.                           │
│                                     │
│  [OK]                               │
└─────────────────────────────────────┘
```

---

## 4. Allocated Students Modal

```
┌───────────────────────────────────────────────────────────────┐
│  Allocated Students                      385 students         │
│  ┌─ Search ────────────────────────────┐                      │
│  │ 🔍 Search by name or ID             │                      │
│  └─────────────────────────────────────┘                      │
├───────────────────────────────────────────────────────────────┤
│                                                                │
│  ┌─ Name ──────┬─ ID ─────┬─ Room ─┬─ Block ┬─ Check-in ──┐│
│  │ Rajesh Kumar│ STU-101  │ A-101  │   A    │ Aug 1, 2025 ││
│  ├─────────────┼──────────┼────────┼────────┼─────────────┤│
│  │ Ankit Sharma│ STU-102  │ A-102  │   A    │ Aug 1, 2025 ││
│  ├─────────────┼──────────┼────────┼────────┼─────────────┤│
│  │ Pooja Singh │ STU-201  │ C-201  │   C    │ Aug 2, 2025 ││
│  ├─────────────┼──────────┼────────┼────────┼─────────────┤│
│  │ Neha Gupta  │ STU-202  │ C-202  │   C    │ Aug 2, 2025 ││
│  ├─────────────┼──────────┼────────┼────────┼─────────────┤│
│  │ Sanjay Patel│ STU-103  │ B-103  │   B    │ Aug 3, 2025 ││
│  └─────────────┴──────────┴────────┴────────┴─────────────┘│
│                                                                │
│  [Close]                                                       │
└───────────────────────────────────────────────────────────────┘
```

---

## User Flow Diagrams

### Flow 1: Approve Application

```
Start
  ↓
Click "Pending Applications" or Applications metric
  ↓
Applications Modal Opens
  ↓
Review student: Amit Kumar (Male, CGPA 8.5)
  ↓
Click "Approve" button
  ↓
Room Allocation Modal Opens
  ↓
Select Block: "Block A" (Boys hostel with availability)
  ↓
Select Floor: "Floor 2"
  ↓
Select Room: "Room 05"
  ↓
Preview: "Room A-05 on Floor 2 will be allocated" ✓
  ↓
Click "Allocate Room"
  ↓
Success Alert: "✅ Room Allocated Successfully!"
  ↓
Notification sent to student
  ↓
Dashboard updates (Pending: 18 → 17, Occupied: 385 → 386)
  ↓
End
```

---

### Flow 2: Update Maintenance

```
Start
  ↓
Click "Maintenance" button or maintenance metric
  ↓
Maintenance Modal Opens
  ↓
See request: MNT-001, A-205, Plumbing, High Priority, Pending
  ↓
Click "Update Status" dropdown
  ↓
Select "In Progress"
  ↓
Alert: "✅ Status Updated!"
  ↓
Notification sent to reporter and team
  ↓
Statistics update: Pending -1, In Progress +1
  ↓
Badge color changes: Orange → Blue
  ↓
End
```

---

### Flow 3: Export Report

```
Start
  ↓
Click "Occupancy Reports" button
  ↓
Occupancy Modal Opens
  ↓
View block-wise data and charts
  ↓
Click "Export Report" button
  ↓
Alert: "Exporting occupancy report..."
  ↓
CSV file prepared with:
  - All blocks
  - Room numbers
  - Student names
  - Occupancy rates
  ↓
Download starts
  ↓
Open in Excel/Google Sheets
  ↓
End
```

---

### Flow 4: Reject Application

```
Start
  ↓
Open Applications Modal
  ↓
Review application: Ravi Kumar
  ↓
Click "Reject" button
  ↓
Prompt: "Enter rejection reason:"
  ↓
Type: "No vacancy in requested block"
  ↓
Click OK
  ↓
Notification added to system
  ↓
Alert: "❌ Application Rejected"
  ↓
Notification sent to student with reason
  ↓
Application removed from pending list
  ↓
Pending count updates: 18 → 17
  ↓
End
```

---

## Color Legend

### Status Colors:
- 🟢 **Green**: Success, Available, Resolved, Low Priority
- 🟡 **Yellow**: Warning, Moderate, Medium Priority
- 🔴 **Red**: Urgent, High Priority, Error
- 🔵 **Blue**: Info, In Progress, Neutral

### Occupancy Colors:
- 🟢 **Green Bar**: < 70% occupancy (Healthy)
- 🟡 **Yellow Bar**: 70-90% occupancy (Moderate)
- 🔴 **Red Bar**: > 90% occupancy (High - Action needed)

### Button Colors:
- **Blue**: Primary actions (Approve, Allocate)
- **Green**: Success actions (Export, Confirm)
- **Orange**: Warning actions (Reject, Cancel)
- **Purple**: Info actions (View Reports)

---

## Keyboard Shortcuts (Future Enhancement)

- `Ctrl + A`: Open Applications
- `Ctrl + O`: Open Occupancy
- `Ctrl + M`: Open Maintenance
- `Ctrl + S`: Open Students
- `Esc`: Close modal
- `Enter`: Confirm action

---

## Mobile View

```
┌──────────────────────────┐
│ Hostel Management        │
├──────────────────────────┤
│ ┌──────────────────────┐ │
│ │ 🏢 Capacity: 500     │ │
│ │    77% occupied      │ │
│ └──────────────────────┘ │
│                          │
│ ┌──────────────────────┐ │
│ │ 📄 Applications: 18  │ │
│ │    [View]            │ │
│ └──────────────────────┘ │
│                          │
│ ┌──────────────────────┐ │
│ │ 🔧 Maintenance: 7    │ │
│ │    [View]            │ │
│ └──────────────────────┘ │
│                          │
│ [Block Stats ▼]         │
│ [Recent Activity ▼]     │
└──────────────────────────┘
```

---

## Tips & Best Practices

### For Wardens:
✓ Check "Urgent Maintenance" alerts daily
✓ Review applications by CGPA and distance
✓ Monitor Block B (90% occupancy - near full)
✓ Export reports weekly for records
✓ Update maintenance status promptly

### For Efficiency:
✓ Use search and filters in modals
✓ Click metric cards for quick access
✓ Check recent activity for updates
✓ Review alerts panel for warnings
✓ Export data before month-end

---

**🎉 All features working perfectly! Ready to use!**
