/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package com.srms.model;

/**
 *
 * @author krisha
 */
public class Student {

    private int id;
    private String name;
    private String email;
    private String course;
    private int semester;
    private double cgpa;
    private String phone;

    // Default constructor
    public Student() {}

    // Parameterized constructor (without id — for INSERT)
    public Student(String name, String email, String course, int semester, double cgpa, String phone) {
        this.name = name;
        this.email = email;
        this.course = course;
        this.semester = semester;
        this.cgpa = cgpa;
        this.phone = phone;
    }

    // Full constructor (with id — for SELECT)
    public Student(int id, String name, String email, String course, int semester, double cgpa, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.course = course;
        this.semester = semester;
        this.cgpa = cgpa;
        this.phone = phone;
    }

    // ── Getters ──────────────────────────────────────
    public int getId()         { return id; }
    public String getName()    { return name; }
    public String getEmail()   { return email; }
    public String getCourse()  { return course; }
    public int getSemester()   { return semester; }
    public double getCgpa()    { return cgpa; }
    public String getPhone()   { return phone; }

    // ── Setters ──────────────────────────────────────
    public void setId(int id)              { this.id = id; }
    public void setName(String name)       { this.name = name; }
    public void setEmail(String email)     { this.email = email; }
    public void setCourse(String course)   { this.course = course; }
    public void setSemester(int semester)  { this.semester = semester; }
    public void setCgpa(double cgpa)       { this.cgpa = cgpa; }
    public void setPhone(String phone)     { this.phone = phone; }

    @Override
    public String toString() {
        return "Student{id=" + id + ", name='" + name + "', course='" + course +
               "', semester=" + semester + ", cgpa=" + cgpa + "}";
    }
}
