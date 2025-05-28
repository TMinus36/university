# 📦 Inventory Tracker (C++) — Project Overview & Technical Documentation

## 📝 Project Description
The Inventory Tracker is a command-line C++ application that simulates an inventory management system tailored for small business needs. This tool enables users to add, modify, delete, and persist inventory records using object-oriented principles and file operations.

---

## 🧠 Learning Objectives
- Implement real-world object-oriented programming in C++
- Utilize vectors (`std::vector`) for dynamic, in-memory storage
- Apply file stream operations (`fstream`) to read/write persistent data
- Understand modular architecture via header and source files

---

## 📁 Project Structure
```
InventoryTracker/
├── Product.h            # Declaration of Product class
├── Product.cpp          # Implementation of Product class methods
├── InventoryManager.h   # Declaration of InventoryManager class
├── InventoryManager.cpp # Inventory operations logic
├── main.cpp             # CLI and user interaction
├── inventory.txt        # Data persistence file
└── CPLUSPLUS.md         # Extended documentation
```

---

## 📌 Feature Breakdown

### Product Class (`Product.h/.cpp`)
- Fields: `id`, `name`, `quantity`, `price`
- Functions: Getters, Setters, and a `display()` method for console output
- Implements encapsulation and formatted display output

### InventoryManager (`InventoryManager.h/.cpp`)
- Manages a `std::vector<Product>` container
- Functionalities:
  - Add new product
  - Search and retrieve by ID
  - Edit and delete entries
  - File read/write using CSV-like format

### User Interface (`main.cpp`)
- Console-based menu with options for all inventory functions
- Uses `std::cin` and `std::cout` for user interaction

---

## 🛠 Example Use Cases
- Retailer inventory control
- Classroom project on file I/O
- Demonstrating encapsulation and container classes

---

## ✅ Future Improvements
- Add category/tag filtering
- Replace flat file with SQLite backend
- Add sorting and reporting features

---

## 👤 Author
Timothy Harris — T-Minus36
