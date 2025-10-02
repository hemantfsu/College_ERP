-- ================================================================
-- COLLEGE ERP DATABASE SCHEMA FOR SUPABASE
-- Copy and paste this entire file into Supabase SQL Editor
-- ================================================================

-- ================================================================
-- STEP 1: CREATE ENUM TYPES
-- ================================================================

-- User roles
CREATE TYPE user_role AS ENUM ('admin', 'clerk', 'faculty', 'student', 'hostel-manager');

-- Admission status
CREATE TYPE admission_status AS ENUM ('Pending', 'Approved', 'Rejected');

-- Fee payment status
CREATE TYPE fee_status AS ENUM ('Pending', 'Paid', 'Overdue');

-- Hostel maintenance status
CREATE TYPE maintenance_status AS ENUM ('Pending', 'In Progress', 'Resolved');

-- ================================================================
-- STEP 2: CREATE TABLES
-- ================================================================

-- Users table (for authentication and user management)
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  role user_role NOT NULL DEFAULT 'student',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Students table
CREATE TABLE students (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT,
  course TEXT NOT NULL,
  semester INTEGER NOT NULL,
  cgpa DECIMAL(3,2),
  date_of_birth DATE,
  address TEXT,
  guardian_name TEXT,
  guardian_phone TEXT,
  user_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Admissions table
CREATE TABLE admissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  course TEXT NOT NULL,
  gender TEXT NOT NULL,
  date_of_birth DATE NOT NULL,
  address TEXT NOT NULL,
  guardian_name TEXT NOT NULL,
  guardian_phone TEXT NOT NULL,
  status admission_status DEFAULT 'Pending',
  applied_date TIMESTAMPTZ DEFAULT NOW(),
  reviewed_by UUID REFERENCES users(id) ON DELETE SET NULL,
  reviewed_date TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Fees table
CREATE TABLE fees (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  fee_type TEXT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  due_date DATE NOT NULL,
  status fee_status DEFAULT 'Pending',
  payment_date TIMESTAMPTZ,
  transaction_id TEXT,
  semester INTEGER,
  academic_year TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Hostel applications table
CREATE TABLE hostel_applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  room_preference TEXT,
  status admission_status DEFAULT 'Pending',
  allocated_room TEXT,
  allocation_date TIMESTAMPTZ,
  applied_date TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Hostel maintenance table
CREATE TABLE hostel_maintenance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room TEXT NOT NULL,
  issue_type TEXT NOT NULL,
  description TEXT NOT NULL,
  priority TEXT NOT NULL,
  status maintenance_status DEFAULT 'Pending',
  reported_by UUID REFERENCES users(id) ON DELETE SET NULL,
  reported_date TIMESTAMPTZ DEFAULT NOW(),
  resolved_date TIMESTAMPTZ,
  resolved_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Exams table
CREATE TABLE exams (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course TEXT NOT NULL,
  semester INTEGER NOT NULL,
  subject TEXT NOT NULL,
  exam_type TEXT NOT NULL,
  exam_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  room TEXT,
  total_marks INTEGER NOT NULL,
  created_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Attendance table
CREATE TABLE attendance (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  course TEXT NOT NULL,
  subject TEXT NOT NULL,
  date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('Present', 'Absent', 'Late')),
  marked_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, course, subject, date)
);

-- Notifications table
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  read BOOLEAN DEFAULT FALSE,
  link TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- STEP 3: CREATE INDEXES FOR PERFORMANCE
-- ================================================================

CREATE INDEX idx_students_student_id ON students(student_id);
CREATE INDEX idx_students_email ON students(email);
CREATE INDEX idx_students_course ON students(course);
CREATE INDEX idx_students_semester ON students(semester);
CREATE INDEX idx_admissions_status ON admissions(status);
CREATE INDEX idx_admissions_email ON admissions(email);
CREATE INDEX idx_fees_student_id ON fees(student_id);
CREATE INDEX idx_fees_status ON fees(status);
CREATE INDEX idx_fees_due_date ON fees(due_date);
CREATE INDEX idx_hostel_apps_student_id ON hostel_applications(student_id);
CREATE INDEX idx_hostel_apps_status ON hostel_applications(status);
CREATE INDEX idx_hostel_maintenance_status ON hostel_maintenance(status);
CREATE INDEX idx_hostel_maintenance_room ON hostel_maintenance(room);
CREATE INDEX idx_exams_date ON exams(exam_date);
CREATE INDEX idx_exams_course_semester ON exams(course, semester);
CREATE INDEX idx_attendance_student_id ON attendance(student_id);
CREATE INDEX idx_attendance_date ON attendance(date);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(read);

-- ================================================================
-- STEP 4: CREATE TRIGGERS FOR AUTO-UPDATING TIMESTAMPS
-- ================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to all tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_students_updated_at BEFORE UPDATE ON students
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_admissions_updated_at BEFORE UPDATE ON admissions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_fees_updated_at BEFORE UPDATE ON fees
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_hostel_applications_updated_at BEFORE UPDATE ON hostel_applications
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_hostel_maintenance_updated_at BEFORE UPDATE ON hostel_maintenance
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_exams_updated_at BEFORE UPDATE ON exams
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_attendance_updated_at BEFORE UPDATE ON attendance
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_notifications_updated_at BEFORE UPDATE ON notifications
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================================
-- STEP 5: ENABLE ROW LEVEL SECURITY (RLS)
-- ================================================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE admissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE fees ENABLE ROW LEVEL SECURITY;
ALTER TABLE hostel_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE hostel_maintenance ENABLE ROW LEVEL SECURITY;
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- ================================================================
-- STEP 6: CREATE RLS POLICIES
-- ================================================================

-- Users policies
CREATE POLICY "Users can view their own data" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Admins can view all users" ON users
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users WHERE users.id = auth.uid() AND users.role = 'admin'
    )
  );

CREATE POLICY "Users can update their own data" ON users
  FOR UPDATE USING (auth.uid() = id);

-- Students policies
CREATE POLICY "Students can view their own data" ON students
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Faculty and admins can view all students" ON students
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'faculty', 'clerk', 'hostel-manager')
    )
  );

CREATE POLICY "Admins and clerks can insert students" ON students
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

CREATE POLICY "Admins and clerks can update students" ON students
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

-- Admissions policies (public can submit, staff can view)
CREATE POLICY "Anyone can submit admission" ON admissions
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Staff can view admissions" ON admissions
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

CREATE POLICY "Staff can update admissions" ON admissions
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

-- Fees policies
CREATE POLICY "Students can view their own fees" ON fees
  FOR SELECT USING (
    student_id IN (
      SELECT id FROM students WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Staff can view all fees" ON fees
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

CREATE POLICY "Staff can manage fees" ON fees
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'clerk')
    )
  );

-- Hostel applications policies
CREATE POLICY "Students can view their own applications" ON hostel_applications
  FOR SELECT USING (
    student_id IN (
      SELECT id FROM students WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Students can submit applications" ON hostel_applications
  FOR INSERT WITH CHECK (
    student_id IN (
      SELECT id FROM students WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Hostel staff can view all applications" ON hostel_applications
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'hostel-manager')
    )
  );

CREATE POLICY "Hostel staff can update applications" ON hostel_applications
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'hostel-manager')
    )
  );

-- Hostel maintenance policies
CREATE POLICY "Users can view maintenance in their area" ON hostel_maintenance
  FOR SELECT USING (true);

CREATE POLICY "Users can report maintenance issues" ON hostel_maintenance
  FOR INSERT WITH CHECK (auth.uid() = reported_by);

CREATE POLICY "Hostel staff can manage maintenance" ON hostel_maintenance
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'hostel-manager')
    )
  );

-- Exams policies
CREATE POLICY "Students can view exams for their courses" ON exams
  FOR SELECT USING (true);

CREATE POLICY "Faculty can manage exams" ON exams
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'faculty')
    )
  );

-- Attendance policies
CREATE POLICY "Students can view their own attendance" ON attendance
  FOR SELECT USING (
    student_id IN (
      SELECT id FROM students WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Faculty can view all attendance" ON attendance
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'faculty')
    )
  );

CREATE POLICY "Faculty can mark attendance" ON attendance
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'faculty')
    )
  );

CREATE POLICY "Faculty can update attendance" ON attendance
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM users 
      WHERE users.id = auth.uid() 
      AND users.role IN ('admin', 'faculty')
    )
  );

-- Notifications policies
CREATE POLICY "Users can view their own notifications" ON notifications
  FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can update their own notifications" ON notifications
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY "System can create notifications" ON notifications
  FOR INSERT WITH CHECK (true);

-- ================================================================
-- STEP 7: INSERT SEED DATA (OPTIONAL - FOR TESTING)
-- ================================================================

-- Insert test admin user
INSERT INTO users (email, name, role) VALUES
('admin@college.edu', 'Admin User', 'admin'),
('clerk@college.edu', 'Clerk User', 'clerk'),
('faculty@college.edu', 'Faculty User', 'faculty'),
('hostel@college.edu', 'Hostel Manager', 'hostel-manager'),
('student@college.edu', 'Test Student', 'student');

-- Insert test students
INSERT INTO students (student_id, name, email, phone, course, semester, cgpa, user_id) VALUES
('CS2024001', 'Rajesh Kumar', 'rajesh@college.edu', '+91 9876543210', 'B.Tech CSE', 3, 8.5, 
  (SELECT id FROM users WHERE email = 'student@college.edu')),
('CS2024002', 'Priya Singh', 'priya@college.edu', '+91 9876543211', 'B.Tech CSE', 3, 9.0, NULL),
('ME2024001', 'Amit Patel', 'amit@college.edu', '+91 9876543212', 'B.Tech Mechanical', 2, 8.2, NULL),
('EC2024001', 'Sneha Sharma', 'sneha@college.edu', '+91 9876543213', 'B.Tech ECE', 4, 8.8, NULL),
('CS2024003', 'Vikram Reddy', 'vikram@college.edu', '+91 9876543214', 'B.Tech CSE', 1, 7.9, NULL);

-- Insert test admission applications
INSERT INTO admissions (student_name, email, phone, course, gender, date_of_birth, address, guardian_name, guardian_phone, status) VALUES
('Rahul Verma', 'rahul@example.com', '+91 9123456780', 'B.Tech CSE', 'Male', '2006-03-15', '123 Main St, Mumbai', 'Mr. Verma', '+91 9123456781', 'Pending'),
('Anjali Gupta', 'anjali@example.com', '+91 9123456782', 'B.Tech ECE', 'Female', '2006-05-20', '456 Park Ave, Delhi', 'Mrs. Gupta', '+91 9123456783', 'Approved'),
('Kiran Das', 'kiran@example.com', '+91 9123456784', 'B.Tech Mechanical', 'Male', '2006-07-10', '789 Lake Rd, Bangalore', 'Mr. Das', '+91 9123456785', 'Pending');

-- Insert test fees
INSERT INTO fees (student_id, fee_type, amount, due_date, status, semester, academic_year) VALUES
((SELECT id FROM students WHERE student_id = 'CS2024001'), 'Tuition Fee', 50000.00, '2024-07-15', 'Paid', 3, '2024-25'),
((SELECT id FROM students WHERE student_id = 'CS2024001'), 'Hostel Fee', 15000.00, '2024-07-15', 'Pending', 3, '2024-25'),
((SELECT id FROM students WHERE student_id = 'CS2024002'), 'Tuition Fee', 50000.00, '2024-07-15', 'Paid', 3, '2024-25'),
((SELECT id FROM students WHERE student_id = 'ME2024001'), 'Lab Fee', 5000.00, '2024-08-01', 'Pending', 2, '2024-25');

-- Insert test hostel applications
INSERT INTO hostel_applications (student_id, student_name, room_preference, status) VALUES
((SELECT id FROM students WHERE student_id = 'CS2024001'), 'Rajesh Kumar', 'Single Room', 'Approved'),
((SELECT id FROM students WHERE student_id = 'CS2024003'), 'Vikram Reddy', 'Shared Room', 'Pending');

-- Insert test maintenance requests
INSERT INTO hostel_maintenance (room, issue_type, description, priority, status, reported_by) VALUES
('A-101', 'Plumbing', 'Leaking faucet in bathroom', 'High', 'In Progress', (SELECT id FROM users WHERE email = 'student@college.edu')),
('B-205', 'Electrical', 'Fan not working', 'Medium', 'Pending', (SELECT id FROM users WHERE email = 'student@college.edu')),
('C-310', 'Furniture', 'Broken chair', 'Low', 'Resolved', (SELECT id FROM users WHERE email = 'student@college.edu'));

-- Insert test exams
INSERT INTO exams (course, semester, subject, exam_type, exam_date, start_time, end_time, room, total_marks, created_by) VALUES
('B.Tech CSE', 3, 'Data Structures', 'Mid-Term', '2024-10-15', '10:00', '12:00', 'Room 101', 100, (SELECT id FROM users WHERE email = 'faculty@college.edu')),
('B.Tech CSE', 3, 'Database Systems', 'End-Term', '2024-12-20', '14:00', '17:00', 'Room 102', 100, (SELECT id FROM users WHERE email = 'faculty@college.edu')),
('B.Tech Mechanical', 2, 'Thermodynamics', 'Mid-Term', '2024-10-18', '10:00', '12:00', 'Room 201', 100, (SELECT id FROM users WHERE email = 'faculty@college.edu'));

-- Insert test attendance records
INSERT INTO attendance (student_id, course, subject, date, status, marked_by) VALUES
((SELECT id FROM students WHERE student_id = 'CS2024001'), 'B.Tech CSE', 'Data Structures', '2024-10-01', 'Present', (SELECT id FROM users WHERE email = 'faculty@college.edu')),
((SELECT id FROM students WHERE student_id = 'CS2024001'), 'B.Tech CSE', 'Data Structures', '2024-10-02', 'Present', (SELECT id FROM users WHERE email = 'faculty@college.edu')),
((SELECT id FROM students WHERE student_id = 'CS2024002'), 'B.Tech CSE', 'Data Structures', '2024-10-01', 'Absent', (SELECT id FROM users WHERE email = 'faculty@college.edu')),
((SELECT id FROM students WHERE student_id = 'CS2024002'), 'B.Tech CSE', 'Data Structures', '2024-10-02', 'Present', (SELECT id FROM users WHERE email = 'faculty@college.edu'));

-- Insert test notifications
INSERT INTO notifications (user_id, type, title, message, read) VALUES
((SELECT id FROM users WHERE email = 'student@college.edu'), 'info', 'Fee Payment Due', 'Your hostel fee payment is due on 15th July', false),
((SELECT id FROM users WHERE email = 'student@college.edu'), 'success', 'Admission Approved', 'Your admission has been approved', true),
((SELECT id FROM users WHERE email = 'faculty@college.edu'), 'warning', 'Exam Schedule', 'Mid-term exams scheduled for next week', false);

-- ================================================================
-- SETUP COMPLETE!
-- ================================================================
-- You should now see all 9 tables in your Supabase Table Editor:
-- 1. users
-- 2. students
-- 3. admissions
-- 4. fees
-- 5. hostel_applications
-- 6. hostel_maintenance
-- 7. exams
-- 8. attendance
-- 9. notifications
--
-- Next steps:
-- 1. Go to Table Editor and verify all tables are created
-- 2. Check that seed data is inserted (optional)
-- 3. Test the connection in your application
-- ================================================================
