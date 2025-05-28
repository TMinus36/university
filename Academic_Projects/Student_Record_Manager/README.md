# 🎓 Student Record Management System

## 🌟 Project Overview
A comprehensive Java-based Student Record Management System (SRMS) designed for educational institutions to efficiently manage student data, academic records, and administrative tasks. This application showcases robust Java programming practices, clean architecture, and efficient data management techniques.

## 🎯 Key Features

### Core Functionality
- **Student Profile Management**: Store and manage comprehensive student information
- **Course Enrollment**: Handle course registration and class scheduling
- **Gradebook System**: Record and calculate grades with various grading schemes
- **Attendance Tracking**: Monitor and report student attendance
- **Transcript Generation**: Generate official academic transcripts
- **User Authentication**: Secure role-based access control (Admin, Faculty, Student)
- **Data Import/Export**: Support for CSV/Excel data exchange

### Technical Highlights
- **Modern Java Features**: Leveraging Java 11+ features (Streams, Optional, Records)
- **MVC Architecture**: Clear separation of concerns
- **Database Integration**: JDBC with connection pooling
- **Unit Testing**: JUnit 5 with 85%+ code coverage
- **Logging**: Comprehensive logging with SLF4J and Logback
- **Configuration**: Externalized configuration with properties files

## 🛠️ Technical Stack

### Backend
- **Language**: Java 11+
- **Build Tool**: Maven
- **Database**: MySQL/PostgreSQL (JDBC)
- **Testing**: JUnit 5, Mockito, TestContainers
- **Logging**: SLF4J with Logback
- **Documentation**: JavaDoc, Swagger/OpenAPI

### Frontend (Optional)
- **Console UI**: Text-based interface
- **Swing GUI**: Optional desktop interface
- **Web Interface**: Future expansion with Spring Boot

## 🚀 Getting Started

### Prerequisites
- Java Development Kit (JDK) 11 or later
- Maven 3.6+
- MySQL 8.0+ or PostgreSQL 13+
- Git (for version control)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/student-record-manager.git
   cd student-record-manager
   ```

2. **Configure the database**
   - Create a new database in MySQL/PostgreSQL
   - Update `src/main/resources/application.properties` with your database credentials

3. **Build the project**
   ```bash
   mvn clean install
   ```

4. **Initialize the database**
   ```bash
   mvn flyway:migrate
   ```

5. **Run the application**
   ```bash
   mvn exec:java -Dexec.mainClass="com.srms.Main"
   ```

## 💻 Usage

### Command-Line Interface
```
=== Student Record Management System ===
1. Student Management
2. Course Management
3. Gradebook
4. Attendance
5. Reports
6. System Settings
0. Exit

Enter your choice: 
```

### Sample Code: Adding a Student
```java
public class StudentService {
    private final StudentRepository studentRepo;
    
    public Student addStudent(StudentDTO studentDto) {
        // Validate input
        ValidationUtils.validateStudentData(studentDto);
        
        // Check for duplicate student
        if (studentRepo.existsByEmail(studentDto.getEmail())) {
            throw new DuplicateResourceException("Email already in use");
        }
        
        // Map DTO to entity
        Student student = new Student();
        student.setFirstName(studentDto.getFirstName());
        student.setLastName(studentDto.getLastName());
        student.setEmail(studentDto.getEmail());
        student.setDateOfBirth(studentDto.getDateOfBirth());
        
        // Save to database
        return studentRepo.save(student);
    }
}
```

## 🏗️ Project Structure

```
student-record-manager/
├── src/
│   ├── main/
│   │   ├── java/com/srms/
│   │   │   ├── config/       # Configuration classes
│   │   │   ├── controller/   # MVC Controllers
│   │   │   ├── model/        # Domain models
│   │   │   ├── repository/   # Data access layer
│   │   │   ├── service/      # Business logic
│   │   │   ├── dto/          # Data Transfer Objects
│   │   │   ├── exception/    # Custom exceptions
│   │   │   └── Main.java     # Application entry point
│   │   └── resources/        # Configuration files
│   └── test/                 # Test classes
├── docs/                     # Documentation
├── sql/                      # Database scripts
├── pom.xml                   # Maven configuration
└── README.md                 # This file
```

## 🧪 Testing

Run all tests:
```bash
mvn test
```

Generate test coverage report:
```bash
mvn jacoco:report
```

## 📊 Database Schema

### Core Tables
```sql
-- Students table
CREATE TABLE students (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    enrollment_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Courses table
CREATE TABLE courses (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    department VARCHAR(50)
);

-- Enrollments table
CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    UNIQUE(student_id, course_id)
);
```

## 📈 Performance

### Benchmark Results
| Operation | Time Complexity | Notes |
|-----------|----------------|-------|
| Add Student | O(1) | Constant time with proper indexing |
| Find Student | O(1) | Using database indexes |
| Generate Report | O(n) | Linear scan of records |
| Bulk Import | O(n) | Batch processing with transactions |

## 🔒 Security

### Security Measures
- Password hashing with BCrypt
- SQL injection prevention using prepared statements
- Input validation and sanitization
- Role-based access control
- HTTPS for web interface (future)

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

- [Java Documentation](https://docs.oracle.com/en/java/)
- [Maven Documentation](https://maven.apache.org/guides/)
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)
- [Database Design Best Practices](https://www.vertabelo.com/blog/database-design-best-practices/)

---
*Last Updated: May 2025*
