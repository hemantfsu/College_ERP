-- ================================================================
-- DATABASE SCHEMA UPDATE FOR FILE STORAGE
-- Add columns for Backblaze B2 file storage
-- Run this after the main schema is created
-- ================================================================

-- ================================================================
-- UPDATE STUDENTS TABLE - Add photo and file columns
-- ================================================================

ALTER TABLE students
ADD COLUMN IF NOT EXISTS photo_url TEXT,
ADD COLUMN IF NOT EXISTS photo_filename TEXT,
ADD COLUMN IF NOT EXISTS photo_uploaded_at TIMESTAMPTZ;

-- ================================================================
-- CREATE STUDENT_DOCUMENTS TABLE
-- ================================================================

CREATE TABLE IF NOT EXISTS student_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID REFERENCES students(id) ON DELETE CASCADE NOT NULL,
  document_type TEXT NOT NULL, -- e.g., 'aadhar', 'marksheet', 'transfer_certificate', 'photo'
  document_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size INTEGER NOT NULL, -- in bytes
  file_type TEXT NOT NULL, -- MIME type
  uploaded_by UUID REFERENCES users(id) ON DELETE SET NULL,
  uploaded_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- CREATE INDEXES FOR PERFORMANCE
-- ================================================================

CREATE INDEX IF NOT EXISTS idx_student_documents_student_id ON student_documents(student_id);
CREATE INDEX IF NOT EXISTS idx_student_documents_type ON student_documents(document_type);
CREATE INDEX IF NOT EXISTS idx_student_documents_uploaded_at ON student_documents(uploaded_at);

-- ================================================================
-- CREATE TRIGGER FOR AUTO-UPDATING TIMESTAMPS
-- ================================================================

DROP TRIGGER IF EXISTS update_student_documents_updated_at ON student_documents;
CREATE TRIGGER update_student_documents_updated_at 
BEFORE UPDATE ON student_documents
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================================
-- ENABLE ROW LEVEL SECURITY
-- ================================================================

ALTER TABLE student_documents ENABLE ROW LEVEL SECURITY;

-- ================================================================
-- CREATE RLS POLICIES FOR STUDENT_DOCUMENTS
-- ================================================================

-- Allow all authenticated users to view documents (simplified)
CREATE POLICY "Anyone can view student documents" ON student_documents
  FOR SELECT USING (true);

-- Allow all authenticated users to upload documents (simplified)
CREATE POLICY "Anyone can upload student documents" ON student_documents
  FOR INSERT WITH CHECK (true);

-- Allow all authenticated users to delete documents (simplified)
CREATE POLICY "Anyone can delete student documents" ON student_documents
  FOR DELETE USING (true);

-- ================================================================
-- CREATE ADMISSION_DOCUMENTS TABLE (for admission applications)
-- ================================================================

CREATE TABLE IF NOT EXISTS admission_documents (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  admission_id UUID REFERENCES admissions(id) ON DELETE CASCADE NOT NULL,
  document_type TEXT NOT NULL,
  document_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_name TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  file_type TEXT NOT NULL,
  uploaded_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ================================================================
-- CREATE INDEXES
-- ================================================================

CREATE INDEX IF NOT EXISTS idx_admission_documents_admission_id ON admission_documents(admission_id);
CREATE INDEX IF NOT EXISTS idx_admission_documents_type ON admission_documents(document_type);

-- ================================================================
-- CREATE TRIGGER
-- ================================================================

DROP TRIGGER IF EXISTS update_admission_documents_updated_at ON admission_documents;
CREATE TRIGGER update_admission_documents_updated_at 
BEFORE UPDATE ON admission_documents
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ================================================================
-- ENABLE ROW LEVEL SECURITY
-- ================================================================

ALTER TABLE admission_documents ENABLE ROW LEVEL SECURITY;

-- ================================================================
-- CREATE RLS POLICIES
-- ================================================================

-- Anyone can upload documents with admission
CREATE POLICY "Anyone can upload admission documents" ON admission_documents
  FOR INSERT WITH CHECK (true);

-- Anyone can view admission documents (simplified)
CREATE POLICY "Anyone can view admission documents" ON admission_documents
  FOR SELECT USING (true);

-- ================================================================
-- ADD HELPFUL COMMENTS
-- ================================================================

COMMENT ON TABLE student_documents IS 'Stores metadata for student documents stored in Backblaze B2';
COMMENT ON COLUMN student_documents.document_type IS 'Type of document: aadhar, marksheet, transfer_certificate, photo, etc.';
COMMENT ON COLUMN student_documents.file_url IS 'Public URL from Backblaze B2';
COMMENT ON COLUMN student_documents.file_size IS 'File size in bytes';

COMMENT ON TABLE admission_documents IS 'Stores documents uploaded during admission process';

-- ================================================================
-- SAMPLE DATA (Optional - for testing)
-- ================================================================

-- Insert sample document records for existing students
-- INSERT INTO student_documents (student_id, document_type, document_name, file_url, file_name, file_size, file_type, uploaded_by)
-- SELECT 
--   s.id,
--   'photo',
--   'Profile Photo',
--   'https://example.com/placeholder.jpg',
--   'placeholder.jpg',
--   50000,
--   'image/jpeg',
--   (SELECT id FROM users WHERE email = 'admin@college.edu')
-- FROM students s
-- WHERE s.student_id = 'CS2024001';

-- ================================================================
-- MIGRATION COMPLETE
-- ================================================================
-- You can now:
-- 1. Upload files to Backblaze B2
-- 2. Store file metadata in student_documents table
-- 3. Reference files by URL in your application
-- 4. Track document uploads per student
-- ================================================================
