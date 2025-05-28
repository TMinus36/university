package com.srms;

import com.srms.model.Student;
import com.srms.service.StudentManager;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        StudentManager manager = new StudentManager();
        Scanner sc = new Scanner(System.in);
        String choice;
        
        do {
            System.out.println("\n== Student Record Manager ==");
            System.out.println("1. Add Student");
            System.out.println("2. Display All Students");
            System.out.println("3. Search Student by ID");
            System.out.println("4. Save to File");
            System.out.println("5. Load from File");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            
            choice = sc.nextLine();
            
            switch (choice) {
                case "1":
                    System.out.print("Enter ID: ");
                    String id = sc.nextLine();
                    System.out.print("Enter Name: ");
                    String name = sc.nextLine();
                    System.out.print("Enter Major: ");
                    String major = sc.nextLine();
                    System.out.print("Enter GPA: ");
                    double gpa = Double.parseDouble(sc.nextLine());
                    manager.addStudent(new Student(id, name, major, gpa));
                    break;
                    
                case "2":
                    manager.displayAllStudents();
                    break;
                    
                case "3":
                    System.out.print("Enter ID to search: ");
                    Student result = manager.searchById(sc.nextLine());
                    if (result != null) {
                        System.out.println(result);
                    } else {
                        System.out.println("Student not found.");
                    }
                    break;
                    
                case "4":
                    manager.saveToFile("students.dat");
                    break;
                    
                case "5":
                    manager.loadFromFile("students.dat");
                    break;
                    
                case "6":
                    System.out.println("Exiting...");
                    break;
                    
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        } while (!choice.equals("6"));
        
        sc.close();
    }
}
