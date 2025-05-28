# 🎓 Student Record Manager (Java) — Educational Console Application

## 📖 Overview
A command-line Java application that manages student academic records using object-oriented design and persistent storage with Java serialization.

---

## 🎯 Goals
- Build practical Java skills using classes, file handling, and exception management
- Learn to manage state with `ArrayList` and persist it to disk
- Develop a reusable CRUD console interface

---

## 📁 File Breakdown
```
StudentRecordManager/
├── Student.java         # Serializable model class
├── StudentManager.java  # Logic for managing student data
├── Main.java            # User interface and menu
└── students.dat         # Serialized student data (runtime)
```

---

## 🔍 Functional Features
- Add new students with GPA, major, and ID
- Search by ID (case-insensitive)
- Display all students
- Save and load records using Java object serialization

---

## 🔐 Exception Handling
- Invalid GPA parsing
- File not found and I/O exceptions
- `ClassNotFoundException` on deserialization

---

## 🚀 Enhancement Ideas
- GUI frontend using JavaFX or Swing
- Role-based access for student/admin
- MySQL/PostgreSQL backend replacement

---

## 👤 Author
Timothy Harris — T-Minus36
