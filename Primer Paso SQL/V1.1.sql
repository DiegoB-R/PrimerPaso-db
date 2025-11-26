-- ------------------------------------------------------------
-- Normalized schema for PrimerPaso (PostgreSQL)
-- Creates users, student_profiles, company_profiles, jobs, applications, saved_jobs, events
-- Includes optional migration examples from legacy tables `students` and `companies`
-- ------------------------------------------------------------

-- 1) Enable pgcrypto extension for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 2) Core users table (credentials + role)
CREATE TABLE IF NOT EXISTS users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text NOT NULL UNIQUE,
  password_hash text NOT NULL,
  role text NOT NULL CHECK (role IN ('student','company','admin')),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users (lower(email));

-- 3) Student profile (separated from auth)
CREATE TABLE IF NOT EXISTS student_profiles (
  user_id uuid PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  first_name text,
  last_name text,
  phone text,
  university text,
  degree text,
  grad_year int,
  bio text,
  linkedin_url text,
  portfolio_url text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- 4) Company profile
CREATE TABLE IF NOT EXISTS company_profiles (
  user_id uuid PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  name text NOT NULL,
  description text,
  website_url text,
  location text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_company_name ON company_profiles (lower(name));

-- 5) Jobs posted by companies
CREATE TABLE IF NOT EXISTS jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id uuid NOT NULL REFERENCES company_profiles(user_id) ON DELETE CASCADE,
  title text NOT NULL,
  description text NOT NULL,
  location text,
  employment_type text,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_jobs_company ON jobs (company_id);
CREATE INDEX IF NOT EXISTS idx_jobs_title ON jobs USING gin (to_tsvector('spanish', coalesce(title, '')));

-- 6) Applications (student applies to a job)
CREATE TABLE IF NOT EXISTS applications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id uuid NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  student_id uuid NOT NULL REFERENCES student_profiles(user_id) ON DELETE CASCADE,
  cover_letter text,
  status text NOT NULL DEFAULT 'applied' CHECK (status IN ('applied','reviewed','accepted','rejected')),
  applied_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (job_id, student_id)
);

-- 7) Saved jobs (bookmarks)
CREATE TABLE IF NOT EXISTS saved_jobs (
  student_id uuid NOT NULL REFERENCES student_profiles(user_id) ON DELETE CASCADE,
  job_id uuid NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
  saved_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (student_id, job_id)
);

-- 8) Events / audit
CREATE TABLE IF NOT EXISTS events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES users(id) ON DELETE SET NULL,
  event_type text NOT NULL,
  payload jsonb,
  created_at timestamptz NOT NULL DEFAULT now()
);