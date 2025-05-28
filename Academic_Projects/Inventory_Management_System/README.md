# 📦 Inventory Management System

## 🌟 Project Overview
A robust, console-based Inventory Management System built with modern C++ that provides comprehensive tools for product tracking, stock management, and business intelligence. This application demonstrates advanced C++ features, design patterns, and efficient data handling techniques while providing a practical solution for small to medium businesses.

## 🎯 Key Features

### Core Functionality
- **Product Management**: Add, update, and remove products with detailed attributes
- **Inventory Tracking**: Real-time stock level monitoring with low-stock alerts
- **Sales & Purchases**: Record transactions with automatic inventory updates
- **Reporting**: Generate detailed reports (CSV, TXT) on sales, stock levels, and product performance
- **Multi-User System**: Role-based access control (Admin, Manager, Staff)
- **Data Persistence**: Binary file storage with integrity checks
- **Barcode Support**: Generate and scan product barcodes

### Technical Highlights
- **Modern C++17/20 Features**: Smart pointers, STL containers, algorithms
- **Object-Oriented Design**: SOLID principles and design patterns
- **Efficient Data Structures**: Hash maps for O(1) product lookups
- **Exception Handling**: Robust error handling and data validation
- **Modular Architecture**: Easy to extend and maintain

## 🛠️ Technical Stack

### Core Technologies
- **Language**: C++17/20
- **Build System**: CMake 3.15+
- **Testing**: Google Test
- **Documentation**: Doxygen
- **Version Control**: Git

### Dependencies
- **STL**: Containers, Algorithms, I/O Streams
- **Third-party Libraries**:
  - `cxxopts` for command-line argument parsing
  - `nlohmann/json` for JSON support (optional)
  - `spdlog` for logging (optional)

## 🚀 Getting Started

### Prerequisites
- C++17 compatible compiler (GCC 9+, Clang 10+, MSVC 2019+)
- CMake 3.15+
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/inventory-management-system.git
   cd inventory-management-system
   ```

2. **Create build directory**
   ```bash
   mkdir build && cd build
   ```

3. **Configure and build**
   ```bash
   cmake ..
   cmake --build .
   ```

4. **Run the application**
   ```bash
   ./inventory_system
   ```

### Building with Optional Features
```bash
# Build with JSON support
cmake -DUSE_JSON=ON ..

# Build with logging enabled
cmake -DENABLE_LOGGING=ON ..
# Build tests
cmake -DBUILD_TESTS=ON ..
```

## 💻 Usage

### Command-Line Interface
```
Inventory Management System v1.0.0

Usage:
  inventory_system [OPTIONS]

Options:
  -h, --help          Show this help message
  -v, --version       Show version information
  -c, --config FILE    Specify configuration file
  -d, --data-dir DIR   Set data directory
  --debug              Enable debug mode
```

### Main Menu
```
=== Inventory Management System ===
1. Product Management
2. Inventory Control
3. Sales & Purchases
4. Reporting
5. User Management
6. System Settings
0. Exit

Enter your choice: 
```

## 🏗️ Project Structure

```
inventory-management-system/
├── include/            # Header files
│   ├── core/          # Core functionality
│   │   ├── product.h
│   │   ├── inventory.h
│   │   ├── transaction.h
│   │   └── user.h
│   └── utils/         # Utility classes
│       ├── logger.h
│       ├── file_io.h
│       └── validator.h
├── src/               # Source files
│   ├── core/
│   └── utils/
├── tests/             # Unit tests
├── data/              # Data storage
├── docs/              # Documentation
├── CMakeLists.txt     # Build configuration
└── README.md          # This file
```

## 🧪 Testing

Run the test suite with:
```bash
cd build
ctest --output-on-failure
```

Generate code coverage report:
```bash
mkdir -p coverage
cd coverage
cmake -DCMAKE_BUILD_TYPE=Coverage ..
make
test/coverage
```

## 📊 Database Schema

### Products Table
```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sku TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT,
    price REAL NOT NULL,
    cost REAL NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    min_quantity INTEGER DEFAULT 5,
    max_quantity INTEGER DEFAULT 100,
    supplier_id INTEGER,
    barcode TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);
```

## 📈 Performance

### Benchmark Results
| Operation | Time Complexity | Notes |
|-----------|----------------|-------|
| Add Product | O(1) | Amortized constant time with hash map |
| Find Product | O(1) | Direct access with SKU |
| Update Stock | O(1) | In-memory update |
| Generate Report | O(n) | Linear scan of products |
| Save/Load Data | O(n) | Serialization of all records |

## 🔒 Security

### Implemented Security Measures
- Input validation and sanitization
- Secure password hashing with bcrypt
- Role-based access control
- Data encryption at rest (optional)
- Audit logging for sensitive operations

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

- The C++ Standard Library
- [CMake Documentation](https://cmake.org/documentation/)
- [Google Test](https://github.com/google/googletest)
- [Modern C++ Features](https://github.com/AnthonyCalandra/modern-cpp-features)

---
*Last Updated: May 2025*
