-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS pgcrypto;  -- For cryptographic functions
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;  -- For query statistics
CREATE EXTENSION IF NOT EXISTS tablefunc;  -- For crosstab functionality

-- Create ENUM types
CREATE TYPE employment_status AS ENUM ('ACTIVE', 'ON_LEAVE', 'TERMINATED', 'RETIRED');
CREATE TYPE gender_type AS ENUM ('MALE', 'FEMALE', 'OTHER', 'PREFER_NOT_TO_SAY');

-- Departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INTEGER,  -- Self-referencing foreign key
    location VARCHAR(100),
    budget DECIMAL(15, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- Jobs table
CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2),
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id INTEGER REFERENCES jobs(job_id) ON DELETE SET NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    manager_id INTEGER REFERENCES employees(employee_id) ON DELETE SET NULL,
    department_id INTEGER REFERENCES departments(department_id) ON DELETE SET NULL,
    status employment_status DEFAULT 'ACTIVE',
    date_of_birth DATE,
    gender gender_type,
    ssn VARCHAR(20) UNIQUE,  -- Social Security Number (encrypt in production)
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add the foreign key constraint for departments.manager_id after employees table is created
ALTER TABLE departments 
ADD CONSTRAINT fk_department_manager 
FOREIGN KEY (manager_id) 
REFERENCES employees(employee_id) 
ON DELETE SET NULL;

-- Job history
CREATE TABLE job_history (
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE,
    job_id INTEGER REFERENCES jobs(job_id) ON DELETE SET NULL,
    department_id INTEGER REFERENCES departments(department_id) ON DELETE SET NULL,
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id, start_date)
);

-- Dependents
CREATE TABLE dependents (
    dependent_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    ssn VARCHAR(20),  -- Encrypt in production
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Payroll
CREATE TABLE payroll (
    payroll_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    pay_period_start DATE NOT NULL,
    pay_period_end DATE NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    overtime_pay DECIMAL(10, 2) DEFAULT 0,
    bonus DECIMAL(10, 2) DEFAULT 0,
    deductions DECIMAL(10, 2) DEFAULT 0,
    net_pay DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT valid_pay_period CHECK (pay_period_end >= pay_period_start)
);

-- Benefits
CREATE TABLE benefits (
    benefit_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    type VARCHAR(50) NOT NULL,  -- e.g., HEALTH, DENTAL, VISION, RETIREMENT
    cost_employee DECIMAL(10, 2) NOT NULL,
    cost_employer DECIMAL(10, 2) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Employee benefits
CREATE TABLE employee_benefits (
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    benefit_id INTEGER NOT NULL REFERENCES benefits(benefit_id) ON DELETE CASCADE,
    coverage_start_date DATE NOT NULL,
    coverage_end_date DATE,
    coverage_amount DECIMAL(10, 2),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (employee_id, benefit_id, coverage_start_date)
);

-- Time off
CREATE TABLE time_off (
    time_off_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,  -- VACATION, SICK, PERSONAL, etc.
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',  -- PENDING, APPROVED, REJECTED, CANCELLED
    reason TEXT,
    approved_by INTEGER REFERENCES employees(employee_id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT valid_date_range CHECK (end_date >= start_date)
);

-- Performance reviews
CREATE TABLE performance_reviews (
    review_id SERIAL PRIMARY KEY,
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    reviewer_id INTEGER REFERENCES employees(employee_id) ON DELETE SET NULL,
    review_date DATE NOT NULL,
    performance_score NUMERIC(3, 1) CHECK (performance_score >= 1 AND performance_score <= 5),
    strengths TEXT,
    areas_for_improvement TEXT,
    goals TEXT,
    status VARCHAR(20) DEFAULT 'DRAFT',  -- DRAFT, SUBMITTED, APPROVED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Training
CREATE TABLE training (
    training_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    provider VARCHAR(200),
    type VARCHAR(100),  -- e.g., TECHNICAL, LEADERSHIP, COMPLIANCE
    cost DECIMAL(10, 2),
    start_date TIMESTAMP WITH TIME ZONE,
    end_date TIMESTAMP WITH TIME ZONE,
    location VARCHAR(200),
    max_participants INTEGER,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT valid_training_dates CHECK (end_date >= start_date)
);

-- Employee training
CREATE TABLE employee_training (
    employee_id INTEGER NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    training_id INTEGER NOT NULL REFERENCES training(training_id) ON DELETE CASCADE,
    registration_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completion_date TIMESTAMP WITH TIME ZONE,
    status VARCHAR(50) DEFAULT 'REGISTERED',  -- REGISTERED, IN_PROGRESS, COMPLETED, CANCELLED
    score NUMERIC(5, 2),
    feedback TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (employee_id, training_id)
);

-- Create indexes for better performance
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_job ON employees(job_id);
CREATE INDEX idx_employees_manager ON employees(manager_id);
CREATE INDEX idx_job_history_employee ON job_history(employee_id);
CREATE INDEX idx_dependents_employee ON dependents(employee_id);
CREATE INDEX idx_payroll_employee ON payroll(employee_id);
CREATE INDEX idx_time_off_employee ON time_off(employee_id);
CREATE INDEX idx_performance_reviews_employee ON performance_reviews(employee_id);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers to automatically update the updated_at column
CREATE TRIGGER update_employees_updated_at
BEFORE UPDATE ON employees
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_departments_updated_at
BEFORE UPDATE ON departments
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_payroll_updated_at
BEFORE UPDATE ON payroll
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_benefits_updated_at
BEFORE UPDATE ON benefits
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_employee_benefits_updated_at
BEFORE UPDATE ON employee_benefits
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_time_off_updated_at
BEFORE UPDATE ON time_off
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_performance_reviews_updated_at
BEFORE UPDATE ON performance_reviews
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_training_updated_at
BEFORE UPDATE ON training
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create a view for employee directory
CREATE OR REPLACE VIEW vw_employee_directory AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.phone_number,
    e.hire_date,
    j.title AS job_title,
    d.name AS department_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    e.status
FROM employees e
LEFT JOIN jobs j ON e.job_id = j.job_id
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE e.status = 'ACTIVE';

-- Grant appropriate permissions
GRANTANT SELECT ON ALL TABLES IN SCHEMA public TO hr_user;
GRANT SELECT ON vw_employee_directory TO public;