# Faculty & Hostel Roles - Visual Guide

## 🎓 FACULTY ROLE WORKFLOW

```
┌─────────────────────────────────────────────────────────────┐
│                    LOGIN PAGE                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ○ Student                                             │   │
│  │ ● Faculty ← SELECT THIS                              │   │
│  │ ○ Clerk                                               │   │
│  │ ○ Hostel Manager                                      │   │
│  │ ○ Admin                                               │   │
│  │                                                        │   │
│  │ Username: faculty                                     │   │
│  │ Password: faculty123                                  │   │
│  │                                                        │   │
│  │           [Sign In] ───────→                          │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              FACULTY DASHBOARD (/faculty-dashboard)          │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────┐│
│  │ 4 Classes  │  │ 3 Exams    │  │ 12 Grading │  │  78%   ││
│  │ Assigned   │  │ Upcoming   │  │ Pending    │  │  Avg   ││
│  └────────────┘  └────────────┘  └────────────┘  └────────┘│
│       ↓               ↓               ↓              ↓       │
│   [Classes]      [Exams]        [Grading]     [Performance] │
│    Modal          Modal           Modal          Modal       │
│                                                               │
├─────────────────────────────────────────────────────────────┤
│  TODAY'S CLASSES                   PENDING GRADING          │
│  ┌────────────────────┐           ┌────────────────────┐   │
│  │ Data Structures    │           │ Assignment 3       │   │
│  │ CSE301 - 45 stud.  │           │ Due: Oct 5         │   │
│  │ [Mark Attendance]  │           │ 38/45 submitted    │   │
│  └────────────────────┘           └────────────────────┘   │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│  CHARTS                                                      │
│  ┌────────────────────┐           ┌────────────────────┐   │
│  │ Weekly Attendance  │           │ Performance Dist.  │   │
│  │ [Bar Chart]        │           │ [Pie Chart]        │   │
│  └────────────────────┘           └────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Faculty Actions Flow

```
MARK ATTENDANCE:
Click Class Card → "Mark Attendance" → ✓ Success Alert

UPLOAD SYLLABUS:
"My Classes" → Select Class → "Upload" → Choose File → Progress Bar → ✓ Done

UPLOAD MARKS:
"Exams" → Select Exam → "Upload Marks" → CSV/Manual → ✓ Uploaded

EXPORT REPORTS:
"Performance" Modal → "Download" → Choose PDF/CSV → ✓ Downloaded
```

---

## 🏠 HOSTEL ROLE WORKFLOW

```
┌─────────────────────────────────────────────────────────────┐
│                    LOGIN PAGE                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ○ Student                                             │   │
│  │ ○ Faculty                                             │   │
│  │ ○ Clerk                                               │   │
│  │ ● Hostel Manager ← SELECT THIS                       │   │
│  │ ○ Admin                                               │   │
│  │                                                        │   │
│  │ Username: hostel                                      │   │
│  │ Password: hostel123                                   │   │
│  │                                                        │   │
│  │           [Sign In] ───────→                          │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              HOSTEL DASHBOARD (/hostel-dashboard)            │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────┐│
│  │ 500 Total  │  │ 385 Rooms  │  │ 18 Pending │  │  7     ││
│  │ Capacity   │  │ Occupied   │  │ Apps       │  │  Maint.││
│  └────────────┘  └────────────┘  └────────────┘  └────────┘│
│       ↓               ↓               ↓              ↓       │
│  [Occupancy]   [Occupancy]     [Applications]  [Maintenance]│
│    Report        Report           Modal           Modal      │
│                                                               │
├─────────────────────────────────────────────────────────────┤
│  HOSTEL BLOCKS (4 blocks)                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Block A      │  │ Block B      │  │ Block C      │ ... │
│  │ Boys Hostel  │  │ Boys Hostel  │  │ Girls Hostel │     │
│  │ 120/150 (80%)│  │ 135/150 (90%)│  │ 80/100 (80%) │     │
│  │ [███████░░]  │  │ [█████████░] │  │ [████████░░] │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│  PENDING APPLICATIONS              MAINTENANCE REQUESTS     │
│  ┌────────────────────┐           ┌────────────────────┐   │
│  │ Amit Kumar         │           │ A-205: Plumbing    │   │
│  │ STU-2023-001       │           │ Priority: HIGH 🔴  │   │
│  │ CGPA: 8.5          │           │ Status: Pending    │   │
│  │ [Reject] [Approve] │           │ [Update Status ▼]  │   │
│  └────────────────────┘           └────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Hostel Actions Flow

```
APPROVE APPLICATION:
Click "Approve" → ALLOCATION MODAL OPENS:

┌───────────────────────────────────────────┐
│ Allocate Room - Amit Kumar (Male)         │
├───────────────────────────────────────────┤
│ Student: STU-2023-001, CGPA: 8.5         │
│                                           │
│ Select Block:  [Block A ▼] (30 avail.)   │
│ Select Floor:  [Floor 1 ▼]               │
│ Select Room:   [Room 01 ▼]               │
│                                           │
│ ✓ Room A-01 on Floor 1 will be allocated│
│                                           │
│      [Cancel]  [Allocate Room]           │
└───────────────────────────────────────────┘
                    ↓
            ✓ Success Alert


REJECT APPLICATION:
Click "Reject" → Enter Reason → ✓ Rejection Sent

UPDATE MAINTENANCE:
Select Request → Status Dropdown → Choose "Resolved" → ✓ Updated

EXPORT REPORTS:
"Occupancy Reports" → "Export" → Choose CSV/PDF → ✓ Downloaded
```

---

## 🗺️ NAVIGATION MENUS

### Faculty Navigation (Left Sidebar)
```
┌────────────────────────┐
│ [🏠] Dashboard          │ ← Main overview
│ [👥] My Classes         │ ← Class management
│ [📝] Exams              │ ← Exam management
│ [📊] Student Performance│ ← Analytics
│ [✓] Attendance          │ ← Mark attendance
│ [⚙️] Settings           │ ← Account settings
└────────────────────────┘
```

### Hostel Navigation (Left Sidebar)
```
┌────────────────────────┐
│ [🏠] Dashboard          │ ← Main overview
│ [📋] Applications       │ ← Pending apps
│ [🏢] Occupancy          │ ← Reports
│ [🔧] Maintenance        │ ← Request tracking
│ [📊] Reports            │ ← Data export
│ [⚙️] Settings           │ ← Account settings
└────────────────────────┘
```

---

## 📊 DATA STRUCTURE VISUALIZATION

### Faculty Data Model
```
FacultyDashboard
├── Stats
│   ├── assignedClasses: 4
│   ├── totalStudents: 180
│   ├── upcomingExams: 3
│   └── pendingGrading: 12
│
├── Classes[]
│   ├── Class 1: Data Structures (CSE301)
│   │   ├── students: 45
│   │   ├── schedule: "Mon, Wed, Fri - 09:00 AM"
│   │   ├── attendanceMarked: true
│   │   └── syllabusUploaded: true
│   └── ... (3 more classes)
│
├── Exams[]
│   ├── Exam 1: Data Structures Mid-Sem
│   │   ├── date: Oct 15, 2025
│   │   ├── students: 45
│   │   ├── questionsUploaded: true
│   │   └── marksUploaded: false
│   └── ... (2 more exams)
│
└── GradingTasks[]
    ├── Task 1: Assignment 3
    │   ├── subject: Data Structures
    │   ├── submitted: 38/45
    │   └── dueDate: Oct 5
    └── ... (11 more tasks)
```

### Hostel Data Model
```
HostelDashboard
├── Stats
│   ├── totalCapacity: 500
│   ├── occupiedRooms: 385
│   ├── pendingApplications: 18
│   └── maintenanceRequests: 7
│
├── Blocks[]
│   ├── Block A (Boys)
│   │   ├── capacity: 150
│   │   ├── occupied: 120
│   │   └── available: 30
│   └── ... (3 more blocks)
│
├── Applications[]
│   ├── App 1: Amit Kumar
│   │   ├── studentId: STU-2023-001
│   │   ├── gender: Male
│   │   ├── cgpa: 8.5
│   │   └── status: Pending
│   └── ... (17 more apps)
│
└── MaintenanceRequests[]
    ├── Request 1: A-205 Plumbing
    │   ├── priority: High
    │   ├── status: Pending
    │   └── issueType: Plumbing
    └── ... (6 more requests)
```

---

## 🎨 COLOR CODING SYSTEM

### Faculty Dashboard
```
Metric Cards:
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
│ BLUE    │ │ PURPLE  │ │ ORANGE  │ │ GREEN   │
│ Classes │ │ Exams   │ │ Grading │ │ Perform.│
└─────────┘ └─────────┘ └─────────┘ └─────────┘

Status Badges:
🟢 Green   = Uploaded, Completed, Good
🟡 Yellow  = Pending, Due Soon
🔴 Red     = Overdue, Missing
🔵 Blue    = In Progress, Information
```

### Hostel Dashboard
```
Metric Cards:
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐
│ BLUE    │ │ GREEN   │ │ PURPLE  │ │ ORANGE  │
│ Capacity│ │ Occupied│ │ Apps    │ │ Maint.  │
└─────────┘ └─────────┘ └─────────┘ └─────────┘

Occupancy Bars:
🟢 Green   = <70% occupancy (Good availability)
🟡 Yellow  = 70-90% occupancy (Moderate)
🔴 Red     = >90% occupancy (High, warn user)

Priority Badges:
🔴 Red     = High Priority (Urgent)
🟡 Yellow  = Medium Priority (Standard)
🟢 Green   = Low Priority (Can wait)
```

---

## 🔄 STATE FLOW DIAGRAM

### Faculty: Upload Syllabus Flow
```
User Action → State Update → UI Feedback

Click Upload
    ↓
setShowUploadModal(true)
    ↓
Modal Opens → Select File
    ↓
setSelectedFile(file)
    ↓
Click "Upload" Button
    ↓
setUploadProgress(0 → 100)
    ↓
Progress Bar Animation
    ↓
addNotification("Success")
    ↓
setShowUploadModal(false)
    ↓
Success Alert Shown
```

### Hostel: Allocate Room Flow
```
User Action → State Update → UI Feedback

Click "Approve"
    ↓
setSelectedApplication(app)
    ↓
setShowAllocationModal(true)
    ↓
Allocation Modal Opens
    ↓
Select Block → setSelectedBlock(block)
Select Floor → setSelectedFloor(floor)
Select Room  → setSelectedRoom(room)
    ↓
Click "Allocate Room"
    ↓
handleAllocateRoom()
    ↓
addNotification("Success")
    ↓
setShowAllocationModal(false)
    ↓
Success Alert + Reset States
```

---

## 📱 RESPONSIVE DESIGN

### Desktop View (>1024px)
```
┌─────────────────────────────────────────────────────────┐
│ Header (Full width)                                     │
├───────┬─────────────────────────────────────────────────┤
│       │  ┌────┐ ┌────┐ ┌────┐ ┌────┐                  │
│ Side  │  │ M1 │ │ M2 │ │ M3 │ │ M4 │  (4 columns)    │
│ bar   │  └────┘ └────┘ └────┘ └────┘                  │
│       │                                                 │
│ Nav   │  ┌─────────────────┐ ┌─────────────────┐      │
│ Menu  │  │   Chart 1       │ │   Chart 2       │      │
│       │  └─────────────────┘ └─────────────────┘      │
│       │                                                 │
└───────┴─────────────────────────────────────────────────┘
```

### Tablet View (768-1024px)
```
┌────────────────────────────────────┐
│ Header (Full width)                │
├───────┬────────────────────────────┤
│       │  ┌────┐ ┌────┐            │
│ Side  │  │ M1 │ │ M2 │ (2 cols)   │
│ bar   │  └────┘ └────┘            │
│       │  ┌────┐ ┌────┐            │
│       │  │ M3 │ │ M4 │            │
│       │  └────┘ └────┘            │
└───────┴────────────────────────────┘
```

### Mobile View (<768px)
```
┌────────────────┐
│ ☰ Header       │
├────────────────┤
│  ┌──────────┐  │
│  │    M1    │  │
│  └──────────┘  │
│  ┌──────────┐  │
│  │    M2    │  │
│  └──────────┘  │
│  ┌──────────┐  │
│  │    M3    │  │
│  └──────────┘  │
│  ┌──────────┐  │
│  │    M4    │  │
│  └──────────┘  │
└────────────────┘
(1 column, stacked)
```

---

## 🎯 QUICK ACCESS CHART

### Faculty Features Matrix
| Feature | Location | Action | Modal |
|---------|----------|--------|-------|
| View Classes | Dashboard | Click metric card | Classes Modal |
| Mark Attendance | Class card | Click button | Alert |
| Upload Syllabus | Classes Modal | Upload button | Upload Modal |
| View Exams | Dashboard | Click metric card | Exams Modal |
| Upload Questions | Exams Modal | Upload button | Upload Modal |
| Upload Marks | Exams Modal | Upload marks | Upload Modal |
| View Performance | Dashboard | Click metric card | Performance Modal |
| Export Reports | Performance | Download button | File Download |
| View Grading | Dashboard | Click metric card | Grading Modal |

### Hostel Features Matrix
| Feature | Location | Action | Modal |
|---------|----------|--------|-------|
| View Applications | Dashboard | Click metric card | Applications Modal |
| Approve App | Application card | Approve button | Allocation Modal |
| Reject App | Application card | Reject button | Prompt |
| Allocate Room | Allocation Modal | Select & confirm | Success Alert |
| View Occupancy | Dashboard | Click metric card | Occupancy Modal |
| Export Reports | Occupancy Modal | Export button | File Download |
| View Maintenance | Dashboard | Click metric card | Maintenance Modal |
| Update Status | Maintenance row | Status dropdown | Success Alert |
| View Students | Quick Action | Students button | Students Modal |

---

## ✅ TESTING QUICK COMMANDS

```bash
# Test Faculty Login
1. Navigate to http://localhost:5173/login
2. Select "Faculty" role
3. Enter: faculty / faculty123
4. Verify redirect to /faculty-dashboard
5. Check all 4 metric cards visible

# Test Hostel Login
1. Navigate to http://localhost:5173/login
2. Select "Hostel Manager" role
3. Enter: hostel / hostel123
4. Verify redirect to /hostel-dashboard
5. Check all 4 block cards visible

# Test Navigation
Faculty: Should see 6 menu items
Hostel: Should see 6 menu items
Other roles: Should not see these options

# Test Modals
Click any metric card → Modal should open
Click X or Cancel → Modal should close
Check data renders correctly

# Test Actions
Faculty: Mark attendance → Success alert
Hostel: Approve application → Allocation modal
Both: Check notifications appear
```

---

**Created**: October 2025  
**Version**: 1.0.0  
**Status**: Visual Guide Complete ✅
