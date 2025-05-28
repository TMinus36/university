package com.srms.model;

import java.io.Serializable;

/**
 * Represents a student in the Student Record Management System.
 * Implements Serializable to allow for object serialization for file storage.
 */
public class Student implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String id;      // Unique student ID
    private String name;    // Student's full name
    private String major;   // Major field of study
    private double gpa;     // GPA score
    
    /**
     * Constructs a new Student with the specified details.
     *
     * @param id    the student's ID
     * @param name  the student's name
     * @param major the student's major
     * @param gpa   the student's GPA
     */
    public Student(String id, String name, String major, double gpa) {
        this.id = id;
        this.name = name;
        this.major = major;
        this.gpa = gpa;
    }
    
    // Getters
    public String getId() { return id; }
    
    public String getName() { return name; }
    
    public String getMajor() { return major; }
    
    public double getGpa() { return gpa; }
    
    // Setters
    public void setId(String id) { this.id = id; }
    
    public void setName(String name) { this.name = name; }
    
    public void setMajor(String major) { this.major = major; }
    
    public void setGpa(double gpa) { this.gpa = gpa; }
    
    /**
     * Returns a string representation of the student.
     *
     * @return a formatted string containing the student's details
     */
    @Override
    public String toString() {
        return String.format("ID: %s | Name: %s | Major: %s | GPA: %.2f", id, name, major, gpa);
    }
}
