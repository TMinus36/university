package com.srms.service;

import com.srms.model.Student;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Manages student records including CRUD operations and file persistence.
 */
public class StudentManager {
    private final List<Student> students;

    public StudentManager() {
        this.students = new ArrayList<>();
    }

    /**
     * Adds a new student to the manager.
     *
     * @param student the student to add
     */
    public void addStudent(Student student) {
        if (student != null) {
            students.add(student);
            System.out.println("Student added successfully!");
        }
    }

    /**
     * Displays all students in the system.
     */
    public void displayAllStudents() {
        if (students.isEmpty()) {
            System.out.println("No students in the system.");
            return;
        }
        System.out.println("\n=== All Students ===");
        for (Student student : students) {
            System.out.println(student);
        }
    }

    /**
     * Searches for a student by ID.
     *
     * @param id the student ID to search for
     * @return the found student, or null if not found
     */
    public Student searchById(String id) {
        for (Student student : students) {
            if (student.getId().equalsIgnoreCase(id)) {
                return student;
            }
        }
        return null;
    }

    /**
     * Saves all students to a file using object serialization.
     *
     * @param filename the name of the file to save to
     */
    public void saveToFile(String filename) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename))) {
            oos.writeObject(students);
            System.out.println("Student data saved to " + filename);
        } catch (IOException e) {
            System.err.println("Error saving student data: " + e.getMessage());
        }
    }

    /**
     * Loads students from a file using object deserialization.
     *
     * @param filename the name of the file to load from
     */
    @SuppressWarnings("unchecked")
    public void loadFromFile(String filename) {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
            List<Student> loadedStudents = (List<Student>) ois.readObject();
            students.clear();
            students.addAll(loadedStudents);
            System.out.println("Student data loaded from " + filename);
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error loading student data: " + e.getMessage());
        }
    }

    /**
     * Gets the list of all students.
     *
     * @return a list of all students
     */
    public List<Student> getAllStudents() {
        return new ArrayList<>(students);
    }
}
