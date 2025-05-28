# 💼 HR Database Management System

## 🌟 Project Overview
A comprehensive Human Resources Database System built with PostgreSQL, designed to manage employee data, department structures, payroll, benefits, and performance metrics. This project demonstrates advanced database design principles, complex SQL queries, and data analysis capabilities for HR analytics.

## 🎯 Key Features

### Core Functionality
- **Employee Lifecycle Management**: From onboarding to offboarding
- **Department & Organization Structure**: Hierarchical department management
- **Payroll & Benefits Administration**: Salary tracking and benefits management
- **Time & Attendance**: Work hours and leave management
- **Performance Management**: Employee evaluations and goal tracking
- **Reporting & Analytics**: Custom reports and data visualization
- **Self-Service Portal**: Employee self-service features (future)

### Technical Highlights
- **Normalized Database Schema**: 3NF design with proper relationships
- **Advanced SQL Features**: Window functions, CTEs, and materialized views
- **Performance Optimization**: Indexing and query optimization
- **Data Security**: Role-based access control and data encryption
- **Backup & Recovery**: Automated backup procedures

## 🛠️ Technical Stack

### Database
- **RDBMS**: PostgreSQL 13+
- **Extensions**:
  - `pgcrypto` for encryption
  - `pg_partman` for table partitioning
  - `pg_stat_statements` for query analysis
  - `tablefunc` for crosstab queries

### Development Tools
- **Version Control**: Git
- **Database Design**: dbdiagram.io, pgModeler
- **SQL IDE**: DBeaver, pgAdmin 4
- **Documentation**: SQL Doc, Markdown

## 🚀 Getting Started

### Prerequisites
- PostgreSQL 13 or later
- pgAdmin 4 (optional)
- Basic SQL knowledge

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hr-database-system.git
   cd hr-database-system
   ```

2. **Create a new PostgreSQL database**
   ```sql
   CREATE DATABASE hr_management;
   ```

3. **Run the setup script**
   ```bash
   psql -U username -d hr_management -f sql/schema.sql
   psql -U username -d hr_management -f sql/seed_data.sql
   ```

4. **Verify the installation**
   ```bash
   psql -U username -d hr_management -f sql/verification_queries.sql
   ```

## 💻 Database Schema

### Core Tables

#### Employees
```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id INTEGER REFERENCES jobs(job_id),
    salary DECIMAL(10,2) CHECK (salary > 0),
    manager_id INTEGER REFERENCES employees(employee_id),
    department_id INTEGER REFERENCES departments(department_id),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add index for performance
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_manager ON employees(manager_id);
```

#### Departments
```sql
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    manager_id INTEGER REFERENCES employees(employee_id),
    location_id INTEGER REFERENCES locations(location_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

#### Jobs
```sql
CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CHECK (max_salary > min_salary)
);
```

### Entity Relationship Diagram (Simplified)
```
+-------------+       +-------------+       +---------------+
|  Employees  |       | Departments |       |    Jobs       |
+-------------+       +-------------+       +---------------+
| PK: id      |<----->| PK: id      |<----->| PK: id        |
| name        |       | name        |       | title         |
| email       |       | manager_id  |       | min_salary    |
| job_id      |------>| location_id |       | max_salary    |
| salary      |       +-------------+       +---------------+
| manager_id  |
| dept_id     |
+-------------+
       ^
       |
+-------------+
| Job History|
+-------------+
| PK: emp_id  |
| PK: job_id  |
| start_date  |
| end_date    |
+-------------+
```

## 📊 Sample Queries

### 1. Employee Hierarchy
```sql
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level employees (those who don't report to anyone)
    SELECT 
        employee_id,
        first_name,
        last_name,
        manager_id,
        1 AS level,
        ARRAY[employee_id] AS path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees who report to someone in the current level
    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        eh.level + 1,
        eh.path || e.employee_id
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT 
    employee_id,
    LPAD('>', (level-1)*2, ' ') || first_name || ' ' || last_name AS employee_name,
    level - 1 AS management_level
FROM employee_hierarchy
ORDER BY path;
```

### 2. Department Salary Analysis
```sql
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    MIN(e.salary) AS min_salary,
    MAX(e.salary) AS max_salary,
    SUM(e.salary) AS total_salary_budget
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.status = 'ACTIVE'
GROUP BY d.department_name
ORDER BY total_salary_budget DESC;
```

### 3. Employee Tenure Analysis
```sql
SELECT 
    EXTRACT(YEAR FROM age(CURRENT_DATE, hire_date)) AS years_of_service,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary,
    STRING_AGG(first_name || ' ' || last_name, ', ' ORDER BY hire_date) AS employees
FROM employees
WHERE status = 'ACTIVE'
GROUP BY years_of_service
ORDER BY years_of_service DESC;
```

## 🔧 Database Maintenance

### Performance Optimization
```sql
-- Create indexes for frequently queried columns
CREATE INDEX idx_employee_name ON employees(last_name, first_name);
CREATE INDEX idx_hire_date ON employees(hire_date);

-- Create materialized view for reporting
CREATE MATERIALIZED VIEW mv_department_metrics AS
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary,
    SUM(e.salary) AS total_budget
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.status = 'ACTIVE'
GROUP BY d.department_id, d.department_name;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_department_metrics;
```

### Backup and Restore
```bash
# Create a backup
pg_dump -U username -d hr_management -F c -b -v -f hr_backup.dump

# Restore from backup
pg_restore -U username -d hr_management -v hr_backup.dump
```

## 📈 Reporting and Analytics

### Employee Turnover Rate
```sql
WITH monthly_data AS (
    SELECT 
        DATE_TRUNC('month', updated_at) AS month,
        COUNT(CASE WHEN status = 'TERMINATED' THEN 1 END) AS terminated_count,
        COUNT(*) FILTER (WHERE status = 'ACTIVE') AS active_count
    FROM employees
    WHERE updated_at >= CURRENT_DATE - INTERVAL '1 year'
    GROUP BY DATE_TRUNC('month', updated_at)
)
SELECT 
    TO_CHAR(month, 'YYYY-MM') AS month,
    terminated_count,
    active_count,
    ROUND((terminated_count::DECIMAL / NULLIF(active_count, 0)) * 100, 2) AS turnover_rate
FROM monthly_data
ORDER BY month;
```

### Salary Distribution by Department
```sql
SELECT 
    d.department_name,
    j.job_title,
    COUNT(*) AS employee_count,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY e.salary) AS median_salary,
    ROUND(STDDEV(e.salary), 2) AS salary_stddev
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE e.status = 'ACTIVE'
GROUP BY d.department_name, j.job_title
ORDER BY d.department_name, avg_salary DESC;
```

## 🔒 Security

### User Roles and Permissions
```sql
-- Create roles
CREATE ROLE hr_manager;
CREATE ROLE department_manager;
CREATE ROLE employee_self_service;

-- Grant permissions to HR Manager
GRANTE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO hr_manager;
GRANTE USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO hr_manager;

-- Grant permissions to Department Manager
GRANTE SELECT ON ALL TABLES IN SCHEMA public TO department_manager;
GRANTE UPDATE (salary, job_id, department_id) ON employees TO department_manager;

-- Create a new user and assign role
CREATE USER jane_doe WITH PASSWORD 'secure_password';
GRANT department_manager TO jane_doe;
```

### Data Masking for Sensitive Information
```sql
-- Create a view with masked sensitive data
CREATE VIEW vw_employee_directory AS
SELECT 
    employee_id,
    first_name,
    last_name,
    CONCAT(LEFT(email, 1), '*****', SUBSTRING(email FROM POSITION('@' IN email))) AS email,
    CONCAT('***-***-', RIGHT(phone_number, 4)) AS phone_number,
    department_id,
    job_id,
    hire_date
FROM employees
WHERE status = 'ACTIVE';

-- Grant read access to the view
GRANTE SELECT ON vw_employee_directory TO public;
```

## 📚 Documentation

### Database Documentation
- [Entity Relationship Diagram](docs/er_diagram.pdf)
- [Data Dictionary](docs/data_dictionary.md)
- [API Documentation](docs/api_documentation.md)
- [Change Log](CHANGELOG.md)

### Project Structure
```
hr-database-system/
├── sql/
│   ├── schema/           # Database schema DDL
│   │   ├── tables/
│   │   ├── views/
│   │   ├── functions/
│   │   └── triggers/
│   ├── migrations/       # Database migration scripts
│   ├── seeds/            # Sample data
│   └── reports/          # Common report queries
├── docs/                 # Documentation
├── scripts/              # Utility scripts
├── tests/                # Database tests
└── README.md             # This file
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Timothy Harris (T-Minus36)**  
- GitHub: [@yourusername](https://github.com/yourusername)  
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)  
- Email: your.email@example.com

## 🙏 Acknowledgments

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Database Design Best Practices](https://www.vertabelo.com/blog/database-design-best-practices/)
- [SQL Style Guide](https://www.sqlstyle.guide/)

---
*Last Updated: May 2025*
