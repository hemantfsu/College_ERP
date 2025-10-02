<<<<<<< HEAD
# College ERP - Unified Administration System

A low-cost, responsive, and accessible web application for managing college operations including admissions, fee collection, hostel allocation, and examination records.

## 🎯 Overview

This College ERP system provides a unified platform for educational institutions to manage their daily operations efficiently. Built with modern web technologies, it offers real-time data synchronization, role-based access control, automated receipt generation, and comprehensive dashboards.

### Key Features

- **📋 Admissions Management** - Fast keyboard-first intake forms with duplicate detection
- **💰 Fee Collection** - POS-style counter interface with automated PDF receipt generation
- **🏠 Hostel Management** - Visual occupancy maps and drag-and-drop room allocation
- **📊 Examination Records** - Exam creation, marks upload, and result publishing
- **👥 Student Directory** - Centralized student database with advanced search
- **📈 Admin Dashboards** - Real-time KPIs, charts, and analytics
- **🔐 Role-Based Access** - 8 distinct roles with granular permissions
  - **Student**: Academic records, attendance, fees, results
  - **Faculty**: Class management, exams, grading, performance analytics
  - **Clerk**: Admissions, fees, attendance, ID cards, bulk operations
  - **Hostel Warden**: Accommodation, room allocation, maintenance
  - **Admin**: Full system oversight and management
- **💾 Data Persistence** - Local storage with planned cloud integrations

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ and npm/yarn
- Modern web browser (Chrome, Firefox, Safari, Edge)

### Installation

```bash
# Navigate to project directory
cd college-erp

# Install dependencies
npm install

# Start development server
npm run dev

# Access the application
# Open http://localhost:3000 in your browser
```

### Build for Production

```bash
npm run build
npm run preview
```

## 🎨 Design System

### Color Palette

- **Primary**: `#0B5FFF` (Trustworthy Blue)
- **Success**: `#0BDF8A` (Vibrant Green)
- **Warning**: `#FFB74D` (Warm Orange)
- **Neutral**: `#F6F8FA` (Light Gray), `#FFFFFF` (White), `#1F2937` (Dark Text)

### Typography

- Font Family: Inter
- Body: 16px
- Headings: 20-24px
- Buttons: 14-16px

### Layout

- Sidebar: 240px width (collapsible)
- Content: Max-width 1200px
- Cards: 12px border-radius
- Spacing: 4px grid system

## 👥 User Roles & Permissions

### Available Roles

1. **Admin** - Full system access
2. **Clerk** - Admissions intake and student management
3. **Fee Collector** - Payment processing and receipt generation
4. **Hostel Warden** - Room allocation and occupancy management
5. **Exam Officer** - Exam creation and marks management
6. **Registrar** - Reports and data exports

### Role Switching (Demo Mode)

Use the Settings page to switch between roles and test different permission levels.

## 📱 Core Modules

### 1. Dashboard

**Features:**
- KPI tiles (Total Students, Today Admissions, Today Collections, Hostel Occupancy)
- 30-day collections time-series chart
- Hostel occupancy heatmap
- Quick action buttons
- Real-time alerts for duplicates and pending dues

### 2. Admissions

**Features:**
- Fast intake form optimized for keyboard navigation
- Duplicate detection by Aadhaar/email/phone
- Bulk CSV import (planned)
- Student profile with tabs (Personal, Fees, Hostel, Exams, Documents)
- Audit trail for all changes

**Workflow:**
1. Click "New Admission"
2. Fill required fields (First Name, Last Name, DOB, Aadhaar, Email, Phone, Course)
3. System validates and checks for duplicates
4. Student record created with auto-generated ID
5. Admission confirmation

### 3. Fee Collection

**Features:**
- POS-style counter interface
- Student lookup by ID/name
- Multiple payment methods (Cash, Card, UPI, Bank Transfer)
- Real-time balance calculation
- Automated PDF receipt generation
- Email receipt delivery (planned)
- Payment ledger with filters

**Workflow:**
1. Select student from dropdown
2. View outstanding balance
3. Enter payment amount
4. Choose payment method
5. Process payment
6. Receipt auto-generated and downloadable
7. Student balance updated

### 4. Hostel Management

**Features:**
- Building and floor view
- Visual occupancy status (color-coded)
- Room capacity tracking
- Waiting list management (planned)
- Bulk allocation (planned)

**Room Statuses:**
- 🟢 Available - Empty rooms
- 🟡 Occupied - Partially filled
- 🔴 Full - At capacity
- ⚪ Maintenance - Not available

### 5. Examination Management

**Features:**
- Exam creation wizard
- CSV marks upload with validation
- Result preview before publishing
- Subject-wise marks entry
- Grade calculation
- Exam ledger in student profiles

### 6. Students Directory

**Features:**
- Comprehensive student listing
- Global search (by name, ID, phone, Aadhaar)
- Filter by course, status, hostel
- Export to CSV
- Bulk operations (message, receipt, allocate)
- Individual student profiles

### 7. Settings & Integrations

**Features:**
- Role switcher (demo mode)
- Google Sheets integration (planned)
- Google Drive integration (planned)
- Payment gateway configuration (planned)
- Backup schedule management
- Two-factor authentication (planned)
- Audit log access

## 🔌 Planned Integrations

### Google Workspace
- **Sheets** - Bidirectional student data sync
- **Drive** - Document and receipt storage
- **Forms** - Online admission forms
- **Gmail** - Automated email notifications

### Payment Gateways
- UPI integration
- Razorpay/Paytm
- Bank transfer tracking

### Automation
- Google Apps Script webhooks
- Zapier/Make.com workflows
- Automated receipt generation and emailing
- Daily backup to cloud storage

## 💾 Data Model

### Student Record

```json
{
  "studentId": "COL2025-0001",
  "firstName": "Ramesh",
  "lastName": "Kumar",
  "dob": "2006-06-12",
  "aadhaar": "XXXX-XXXX-1234",
  "email": "ramesh@example.com",
  "phone": "+91-9XXXXXXXXX",
  "course": "BSc Computer Science",
  "admissionDate": "2025-08-01",
  "status": "Active",
  "feeBalance": 12000.00,
  "hostel": { "building": "A", "room": "A-102" },
  "documents": ["drive_link_1", "drive_link_2"],
  "audit": [
    { "by": "clerk1", "ts": "2025-08-02T10:12:00Z", "action": "created" }
  ]
}
```

### Payment Record

```json
{
  "id": "PAY-2025-0001",
  "studentId": "COL2025-0001",
  "amount": 3000,
  "method": "UPI",
  "date": "2025-09-15",
  "receiptNumber": "REC-2025-00001",
  "collectedBy": "fee-collector-1"
}
```

## ♿ Accessibility

### WCAG AA Compliance
- Semantic HTML structure
- ARIA labels on interactive elements
- Keyboard navigation support
- High contrast color ratios (4.5:1 minimum)
- Focus indicators on all interactive elements
- Screen reader friendly

### Keyboard Shortcuts
- `Tab` - Navigate between fields
- `Enter` - Submit forms
- `Esc` - Close modals
- Optimized tab order in forms

## 🎭 Animations & Interactions

### Micro-interactions
- Button press: scale(0.98) - 120ms
- Modal open: fade + scale - 160ms
- Toast notifications: slide up - 200ms
- Table row hover: highlight - 150ms
- Dashboard KPI counters: animate on load - 600ms

All animations respect `prefers-reduced-motion` for accessibility.

## 🔒 Security Features

- Role-based access control (RBAC)
- Audit trail for all data modifications
- Data retention policies
- Secure password handling (planned)
- Two-factor authentication (planned)
- Session timeout
- Data deletion approval workflow

## 📦 Tech Stack

- **Frontend**: React 18 + TypeScript
- **Build Tool**: Vite 5
- **Styling**: Tailwind CSS 3
- **Routing**: React Router 6
- **Charts**: Recharts
- **Icons**: Lucide React
- **PDF Generation**: jsPDF
- **Date Handling**: date-fns
- **State Management**: React Context API
- **Data Persistence**: localStorage (with cloud sync planned)

## 🚧 Roadmap

### Phase 1 (Current - MVP)
- ✅ Core modules (Admissions, Fees, Hostel, Exams)
- ✅ Dashboard with KPIs
- ✅ Role-based UI
- ✅ Local data persistence
- ✅ PDF receipt generation

### Phase 2 (Next)
- 🔄 Google Sheets integration
- 🔄 Google Drive document storage
- 🔄 Email notifications
- 🔄 UPI payment integration
- 🔄 CSV import/export

### Phase 3 (Future)
- 📋 Mobile responsive optimization
- 📋 Offline mode with sync
- 📋 Advanced reporting
- 📋 Student/parent portal
- 📋 Library management
- 📋 Attendance tracking

## 🧪 Testing

### Manual Testing Checklist

- [ ] Admit a new student
- [ ] Process a fee payment and generate receipt
- [ ] Allocate a student to hostel room
- [ ] Create an exam
- [ ] Upload marks (CSV)
- [ ] Switch roles and verify permissions
- [ ] Export data to CSV
- [ ] Test keyboard navigation
- [ ] Verify responsive design on mobile

## 📄 License

This project is open-source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📞 Support

For issues, questions, or feature requests:
- Open an issue on GitHub
- Email: support@collegeerp.example.com
- Documentation: /docs

## 🎓 Demo Credentials

Access the demo with any role (use Settings page to switch):
- Admin User
- Clerk User
- Fee Collector
- Hostel Warden
- Exam Officer
- Registrar

## 📊 System Requirements

### Minimum
- 2GB RAM
- Modern browser (last 2 versions)
- 1280x720 screen resolution
- Stable internet connection (for cloud features)

### Recommended
- 4GB+ RAM
- Chrome/Firefox latest version
- 1920x1080 screen resolution
- High-speed internet

---

**Built with ❤️ for educational institutions**

Version: 1.0.0 | Last Updated: October 2025
=======
# College_ERP
Low-cost erp portal for colleges.
>>>>>>> 6d3b120a7be4f1aeb659687162513a01d6d70e1c
