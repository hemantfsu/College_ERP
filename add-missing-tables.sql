-- ================================================================
-- ADD MISSING TABLES TO COLLEGE ERP DATABASE
-- Run this AFTER supabase-schema.sql and fix-rls-policies.sql
-- ================================================================

-- ================================================================
-- STEP 1: CREATE COURSES TABLE
-- ================================================================

CREATE TABLE IF NOT EXISTS courses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_code TEXT UNIQUE NOT NULL,
  course_name TEXT NOT NULL,
  department TEXT NOT NULL,
  duration_years INTEGER NOT NULL,
  total_semesters INTEGER NOT NULL,
  total_fees DECIMAL(10,2) NOT NULL,
  description TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- STEP 2: CREATE HOSTEL ROOMS TABLE
-- ================================================================

CREATE TABLE IF NOT EXISTS hostel_rooms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_number TEXT UNIQUE NOT NULL,
  building TEXT NOT NULL,
  floor INTEGER NOT NULL,
  room_type TEXT NOT NULL CHECK (room_type IN ('Single', 'Double', 'Triple', 'Quadruple')),
  capacity INTEGER NOT NULL,
  current_occupancy INTEGER DEFAULT 0,
  status TEXT DEFAULT 'Available' CHECK (status IN ('Available', 'Occupied', 'Under Maintenance', 'Reserved')),
  rent_per_month DECIMAL(10,2) NOT NULL,
  amenities TEXT[],
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- STEP 3: CREATE HOSTEL ALLOCATIONS TABLE
-- ================================================================

CREATE TABLE IF NOT EXISTS hostel_allocations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  room_id UUID REFERENCES hostel_rooms(id) ON DELETE CASCADE,
  application_id UUID REFERENCES hostel_applications(id) ON DELETE SET NULL,
  allocated_date TIMESTAMPTZ DEFAULT NOW(),
  check_in_date DATE,
  check_out_date DATE,
  is_active BOOLEAN DEFAULT TRUE,
  rent_amount DECIMAL(10,2) NOT NULL,
  deposit_amount DECIMAL(10,2) DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, room_id, is_active)
);

-- ================================================================
-- STEP 4: CREATE FEE PAYMENTS TABLE
-- ================================================================

CREATE TABLE IF NOT EXISTS fee_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fee_id UUID REFERENCES fees(id) ON DELETE CASCADE,
  student_id UUID REFERENCES students(id) ON DELETE CASCADE,
  amount_paid DECIMAL(10,2) NOT NULL,
  payment_method TEXT NOT NULL CHECK (payment_method IN ('Cash', 'Card', 'UPI', 'Bank Transfer', 'Cheque')),
  payment_date TIMESTAMPTZ DEFAULT NOW(),
  transaction_id TEXT UNIQUE,
  receipt_number TEXT UNIQUE NOT NULL,
  payment_gateway TEXT,
  gateway_response JSONB,
  status TEXT DEFAULT 'Success' CHECK (status IN ('Success', 'Failed', 'Pending', 'Refunded')),
  processed_by UUID REFERENCES users(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- STEP 5: ADD MISSING COLUMNS TO EXISTING TABLES
-- ================================================================

-- Add aadhaar to students if not exists
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'students' AND column_name = 'aadhaar'
  ) THEN
    ALTER TABLE students ADD COLUMN aadhaar TEXT UNIQUE;
  END IF;
END $$;

-- Add gender to students if not exists
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'students' AND column_name = 'gender'
  ) THEN
    ALTER TABLE students ADD COLUMN gender TEXT;
  END IF;
END $$;

-- Add blood_group to students if not exists
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'students' AND column_name = 'blood_group'
  ) THEN
    ALTER TABLE students ADD COLUMN blood_group TEXT;
  END IF;
END $$;

-- Add aadhaar to admissions if not exists
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'admissions' AND column_name = 'aadhaar'
  ) THEN
    ALTER TABLE admissions ADD COLUMN aadhaar TEXT;
  END IF;
END $$;

-- ================================================================
-- STEP 6: CREATE INDEXES FOR PERFORMANCE
-- ================================================================

CREATE INDEX IF NOT EXISTS idx_courses_code ON courses(course_code);
CREATE INDEX IF NOT EXISTS idx_courses_department ON courses(department);
CREATE INDEX IF NOT EXISTS idx_courses_active ON courses(is_active);

CREATE INDEX IF NOT EXISTS idx_hostel_rooms_number ON hostel_rooms(room_number);
CREATE INDEX IF NOT EXISTS idx_hostel_rooms_building ON hostel_rooms(building);
CREATE INDEX IF NOT EXISTS idx_hostel_rooms_status ON hostel_rooms(status);

CREATE INDEX IF NOT EXISTS idx_hostel_allocations_student ON hostel_allocations(student_id);
CREATE INDEX IF NOT EXISTS idx_hostel_allocations_room ON hostel_allocations(room_id);
CREATE INDEX IF NOT EXISTS idx_hostel_allocations_active ON hostel_allocations(is_active);

CREATE INDEX IF NOT EXISTS idx_fee_payments_fee ON fee_payments(fee_id);
CREATE INDEX IF NOT EXISTS idx_fee_payments_student ON fee_payments(student_id);
CREATE INDEX IF NOT EXISTS idx_fee_payments_date ON fee_payments(payment_date);
CREATE INDEX IF NOT EXISTS idx_fee_payments_status ON fee_payments(status);
CREATE INDEX IF NOT EXISTS idx_fee_payments_receipt ON fee_payments(receipt_number);

-- ================================================================
-- STEP 7: CREATE TRIGGERS FOR AUTO-UPDATING TIMESTAMPS
-- ================================================================

DROP TRIGGER IF EXISTS update_courses_updated_at ON courses;
CREATE TRIGGER update_courses_updated_at BEFORE UPDATE ON courses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_hostel_rooms_updated_at ON hostel_rooms;
CREATE TRIGGER update_hostel_rooms_updated_at BEFORE UPDATE ON hostel_rooms
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_hostel_allocations_updated_at ON hostel_allocations;
CREATE TRIGGER update_hostel_allocations_updated_at BEFORE UPDATE ON hostel_allocations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_fee_payments_updated_at ON fee_payments;
CREATE TRIGGER update_fee_payments_updated_at BEFORE UPDATE ON fee_payments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================================
-- STEP 8: CREATE FUNCTION TO UPDATE ROOM OCCUPANCY
-- ================================================================

CREATE OR REPLACE FUNCTION update_room_occupancy()
RETURNS TRIGGER AS $$
BEGIN
  -- Update occupancy when allocation is added/removed
  IF TG_OP = 'INSERT' AND NEW.is_active = TRUE THEN
    UPDATE hostel_rooms 
    SET current_occupancy = current_occupancy + 1,
        status = CASE 
          WHEN current_occupancy + 1 >= capacity THEN 'Occupied'
          ELSE 'Available'
        END
    WHERE id = NEW.room_id;
  ELSIF TG_OP = 'DELETE' AND OLD.is_active = TRUE THEN
    UPDATE hostel_rooms 
    SET current_occupancy = GREATEST(current_occupancy - 1, 0),
        status = 'Available'
    WHERE id = OLD.room_id;
  ELSIF TG_OP = 'UPDATE' THEN
    -- If allocation becomes inactive
    IF OLD.is_active = TRUE AND NEW.is_active = FALSE THEN
      UPDATE hostel_rooms 
      SET current_occupancy = GREATEST(current_occupancy - 1, 0),
          status = 'Available'
      WHERE id = OLD.room_id;
    -- If allocation becomes active
    ELSIF OLD.is_active = FALSE AND NEW.is_active = TRUE THEN
      UPDATE hostel_rooms 
      SET current_occupancy = current_occupancy + 1,
          status = CASE 
            WHEN current_occupancy + 1 >= capacity THEN 'Occupied'
            ELSE 'Available'
          END
      WHERE id = NEW.room_id;
    END IF;
  END IF;
  
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Apply trigger
DROP TRIGGER IF EXISTS update_room_occupancy_trigger ON hostel_allocations;
CREATE TRIGGER update_room_occupancy_trigger
  AFTER INSERT OR UPDATE OR DELETE ON hostel_allocations
  FOR EACH ROW EXECUTE FUNCTION update_room_occupancy();

-- ================================================================
-- STEP 9: ENABLE ROW LEVEL SECURITY
-- ================================================================

ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE hostel_rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE hostel_allocations ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_payments ENABLE ROW LEVEL SECURITY;

-- ================================================================
-- STEP 10: CREATE SIMPLIFIED RLS POLICIES (NO RECURSION)
-- ================================================================

-- Courses policies
CREATE POLICY "Anyone can view courses" ON courses
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage courses" ON courses
  FOR ALL TO authenticated
  USING (true);

-- Hostel rooms policies
CREATE POLICY "Anyone can view hostel rooms" ON hostel_rooms
  FOR SELECT USING (true);

CREATE POLICY "Authenticated users can manage hostel rooms" ON hostel_rooms
  FOR ALL TO authenticated
  USING (true);

-- Hostel allocations policies
CREATE POLICY "Anyone can view hostel allocations" ON hostel_allocations
  FOR SELECT TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can manage hostel allocations" ON hostel_allocations
  FOR ALL TO authenticated
  USING (true);

-- Fee payments policies
CREATE POLICY "Anyone can view fee payments" ON fee_payments
  FOR SELECT TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can manage fee payments" ON fee_payments
  FOR ALL TO authenticated
  USING (true);

-- ================================================================
-- STEP 11: INSERT SAMPLE DATA
-- ================================================================

-- Insert sample courses
INSERT INTO courses (course_code, course_name, department, duration_years, total_semesters, total_fees, description) VALUES
  ('CSE101', 'Computer Science Engineering', 'Engineering', 4, 8, 400000, 'Bachelor of Technology in Computer Science'),
  ('ECE101', 'Electronics & Communication', 'Engineering', 4, 8, 380000, 'Bachelor of Technology in Electronics'),
  ('MCA101', 'Master of Computer Applications', 'Computer Science', 2, 4, 200000, 'Postgraduate program in Computer Applications'),
  ('MBA101', 'Master of Business Administration', 'Management', 2, 4, 300000, 'MBA program with various specializations'),
  ('BBA101', 'Bachelor of Business Administration', 'Management', 3, 6, 180000, 'Undergraduate business program')
ON CONFLICT (course_code) DO NOTHING;

-- Insert sample hostel rooms
INSERT INTO hostel_rooms (room_number, building, floor, room_type, capacity, rent_per_month, amenities) VALUES
  ('A101', 'Block A', 1, 'Double', 2, 3000, ARRAY['WiFi', 'AC', 'Attached Bath']),
  ('A102', 'Block A', 1, 'Triple', 3, 2500, ARRAY['WiFi', 'Fan', 'Common Bath']),
  ('A103', 'Block A', 1, 'Double', 2, 3000, ARRAY['WiFi', 'AC', 'Attached Bath']),
  ('A201', 'Block A', 2, 'Single', 1, 4000, ARRAY['WiFi', 'AC', 'Attached Bath', 'Study Table']),
  ('A202', 'Block A', 2, 'Double', 2, 3000, ARRAY['WiFi', 'AC', 'Attached Bath']),
  ('B101', 'Block B', 1, 'Triple', 3, 2500, ARRAY['WiFi', 'Fan', 'Common Bath']),
  ('B102', 'Block B', 1, 'Quadruple', 4, 2000, ARRAY['WiFi', 'Fan', 'Common Bath']),
  ('B103', 'Block B', 1, 'Triple', 3, 2500, ARRAY['WiFi', 'Fan', 'Common Bath']),
  ('B201', 'Block B', 2, 'Double', 2, 3000, ARRAY['WiFi', 'AC', 'Attached Bath']),
  ('B202', 'Block B', 2, 'Double', 2, 3000, ARRAY['WiFi', 'AC', 'Attached Bath'])
ON CONFLICT (room_number) DO NOTHING;

-- ================================================================
-- SUCCESS MESSAGE
-- ================================================================
-- ✅ All missing tables created successfully!
-- ✅ Courses table with 5 sample courses
-- ✅ Hostel rooms table with 10 sample rooms
-- ✅ Hostel allocations table ready
-- ✅ Fee payments table ready
-- ✅ Auto-update triggers configured
-- ✅ RLS policies applied (simplified, no recursion)
-- 
-- Next steps:
-- 1. Run fix-rls-policies.sql to fix existing tables
-- 2. Test admission form submission
-- 3. Start connecting frontend pages
-- ================================================================
