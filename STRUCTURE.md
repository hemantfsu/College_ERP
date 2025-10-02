# Project Structure - College ERP

```
college-erp/
├── public/                     # Static assets
├── src/
│   ├── components/            # Reusable UI components
│   │   └── Layout.tsx        # Main layout with nav and sidebar
│   ├── contexts/              # React Context providers
│   │   └── AppContext.tsx    # Global state management
│   ├── data/                  # Mock data and constants
│   │   └── mockData.ts       # Sample students, payments, etc.
│   ├── pages/                 # Page components (routes)
│   │   ├── Dashboard.tsx     # KPIs, charts, quick actions
│   │   ├── Admissions.tsx    # Student intake and management
│   │   ├── Fees.tsx          # Payment processing and receipts
│   │   ├── Hostel.tsx        # Room allocation and occupancy
│   │   ├── Exams.tsx         # Exam creation and results
│   │   ├── Students.tsx      # Student directory
│   │   └── Settings.tsx      # System configuration
│   ├── types/                 # TypeScript type definitions
│   │   └── index.ts          # Shared types and interfaces
│   ├── App.tsx               # Root component with routing
│   ├── main.tsx              # Application entry point
│   ├── index.css             # Global styles and Tailwind
│   └── App.css               # Component-specific styles
├── index.html                 # HTML template
├── package.json              # Dependencies and scripts
├── tsconfig.json             # TypeScript configuration
├── vite.config.ts            # Vite build configuration
├── tailwind.config.js        # Tailwind CSS configuration
├── postcss.config.js         # PostCSS configuration
├── README.md                 # Project documentation
├── SETUP.md                  # Installation instructions
└── STRUCTURE.md              # This file

## Key Files Explained

### Configuration Files

**package.json**
- Project metadata
- Dependencies list
- npm scripts (dev, build, preview)

**tsconfig.json**
- TypeScript compiler options
- Module resolution settings
- Type checking rules

**vite.config.ts**
- Dev server configuration
- Build optimization
- Plugin configuration

**tailwind.config.js**
- Custom color palette
- Extended theme (animations, spacing)
- Content paths for purging

### Source Files

**src/main.tsx**
- Application entry point
- Renders root component
- Sets up React 18 strict mode

**src/App.tsx**
- Router configuration
- Route definitions
- Layout wrapper

**src/contexts/AppContext.tsx**
- Global state management
- Student data
- Payments
- Hostel rooms
- Exams
- Notifications
- Local storage persistence

**src/types/index.ts**
- TypeScript interfaces
- Type definitions for:
  - Student
  - Payment
  - HostelRoom
  - Exam
  - ExamResult
  - KPIData
  - NotificationItem
  - UserRole

### Components

**Layout.tsx**
- Top navigation bar
- Collapsible sidebar
- Global search
- User menu
- Notification bell
- Responsive design

### Pages

Each page follows a similar structure:
1. Import necessary hooks and components
2. Access global state from AppContext
3. Define local state for forms/UI
4. Implement CRUD operations
5. Render UI with Tailwind classes

**Dashboard.tsx**
- KPI calculation from real data
- Charts (Recharts)
- Hostel occupancy visualization
- Quick action buttons
- Alert notifications

**Admissions.tsx**
- Student intake form
- Duplicate detection
- Form validation
- Student list table
- Bulk import (planned)

**Fees.tsx**
- POS counter interface
- Student lookup
- Payment processing
- PDF receipt generation (jsPDF)
- Recent payments list

**Hostel.tsx**
- Building/floor organization
- Visual room grid
- Color-coded status
- Occupancy stats
- Room allocation

**Exams.tsx**
- Exam list
- Creation wizard
- Marks upload
- Result publishing
- Subject management

**Students.tsx**
- Complete student directory
- Search and filter
- Export functionality
- Bulk actions
- Student profiles

**Settings.tsx**
- Role switcher (demo)
- Integration configuration
- Backup management
- Security settings
- Audit log access

## Data Flow

```
User Action
    ↓
Page Component
    ↓
AppContext (useApp hook)
    ↓
State Update (setState)
    ↓
useEffect → localStorage
    ↓
Re-render with new data
```

## Styling Architecture

### Tailwind Utility Classes
- Primary styling method
- Custom utilities in index.css
- Responsive breakpoints (sm, md, lg, xl)

### Custom CSS Classes
```css
.btn              - Base button
.btn-primary      - Primary action button
.btn-secondary    - Secondary action button
.btn-success      - Success/confirmation button
.card             - Container card
.input            - Form input field
.label            - Form label
```

### Animation Classes
- animate-fade-in
- animate-scale-in
- animate-slide-up
- animate-button-press

## State Management

### Context Provider (AppContext)
- Wraps entire application
- Provides global state
- Handles CRUD operations
- Persists to localStorage

### Local State (useState)
- Form inputs
- Modal visibility
- UI toggles
- Search queries

## Routing

```
/                  → Dashboard
/admissions        → Admissions
/fees              → Fee Collection
/hostel            → Hostel Management
/exams             → Examination Management
/students          → Students Directory
/settings          → Settings & Configuration
```

## Features by Module

### Dashboard
- ✅ KPI tiles
- ✅ Collections chart
- ✅ Hostel heatmap
- ✅ Quick actions
- ✅ Alerts

### Admissions
- ✅ Fast intake form
- ✅ Duplicate detection
- ✅ Student listing
- ⏳ Bulk CSV import
- ⏳ Profile tabs

### Fees
- ✅ POS interface
- ✅ Student lookup
- ✅ Payment processing
- ✅ PDF receipt generation
- ⏳ Email sending

### Hostel
- ✅ Visual room grid
- ✅ Occupancy tracking
- ✅ Building organization
- ⏳ Drag-drop allocation
- ⏳ Waiting list

### Exams
- ✅ Exam creation
- ✅ Exam listing
- ⏳ CSV marks upload
- ⏳ Result publishing
- ⏳ Grade calculation

### Students
- ✅ Directory table
- ✅ Search functionality
- ✅ Stats overview
- ⏳ CSV export
- ⏳ Bulk operations

### Settings
- ✅ Role switcher
- ✅ Integration UI
- ✅ Backup status
- ⏳ Google Sheets connection
- ⏳ 2FA setup

## Future Enhancements

### Phase 2
- Google Sheets API integration
- Google Drive storage
- Email notifications (SendGrid/Gmail)
- CSV import/export
- Advanced search

### Phase 3
- Mobile app (React Native)
- Offline mode (Service Workers)
- Real-time sync (WebSockets)
- Student portal
- Parent portal
- Library module
- Attendance module

## Development Guidelines

### Adding a New Page
1. Create component in `src/pages/`
2. Add route in `src/App.tsx`
3. Add nav item in `src/components/Layout.tsx`
4. Update types in `src/types/index.ts` if needed

### Adding a New Feature
1. Plan data structure
2. Update types
3. Add to AppContext
4. Implement UI
5. Test CRUD operations
6. Update README

### Code Style
- Use TypeScript strict mode
- Follow React hooks best practices
- Use Tailwind for styling
- Add ARIA labels for accessibility
- Write self-documenting code
- Comment complex logic

## Testing Strategy

### Manual Testing
- Test each CRUD operation
- Verify data persistence
- Check responsive design
- Test keyboard navigation
- Validate forms
- Test role switching

### Automated Testing (Planned)
- Unit tests (Jest)
- Component tests (React Testing Library)
- E2E tests (Playwright/Cypress)
- Accessibility tests (axe)

## Performance Optimization

### Current
- Lazy loading (React Router)
- Local state management
- Efficient re-renders
- Debounced search
- Memoized calculations

### Planned
- Code splitting
- Image optimization
- Server-side rendering
- Progressive Web App
- Caching strategies

---

**Last Updated**: October 2025
**Version**: 1.0.0
