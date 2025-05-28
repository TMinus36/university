# 🏢 Company HR Database (PostgreSQL) — Schema Design & Query Optimization

## 📚 Project Purpose
This SQL-based project demonstrates advanced PostgreSQL capabilities for designing, populating, and querying a human resources (HR) schema with real-world utility.

---

## 🧱 Schema Components
- **departments**: Stores department IDs and names
- **employees**: Contains employee names, hire dates, department foreign key
- **salaries**: Stores salary and bonus info tied to employee IDs

---

## 📁 Files
```
HRDatabaseProject/
├── init_hr.sql      # Creates schema and inserts test data
├── queries.sql      # Complex joins and analytics
└── POSTGRESQL.md    # Documentation
```

---

## 🔍 Example Queries
- Departmental salary averages (`GROUP BY`, `HAVING`)
- Top earners by department using subqueries
- View creation: `high_earners` for easy BI/dashboard reporting

---

## 🛠 Practical Use Cases
- Foundation for employee analytics systems
- Integration with BI tools like Tableau or Grafana
- ORMs like Sequelize, Django ORM, SQLAlchemy

---

## 🏗️ Scaling Ideas
- Add project assignments table (many-to-many)
- Add audit logs and login system
- Build RESTful API on top using Node.js or Django

---

## 👤 Author
Timothy Harris — T-Minus36
