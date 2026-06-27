/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.srms.dao;

import com.srms.model.Student;
import com.srms.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author krisha
 */
public class StudentDAOImpl implements StudentDAO{
     private static final String SQL_INSERT =
        "INSERT INTO students (name, email, course, semester, cgpa, phone) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SQL_SELECT_ALL =
        "SELECT * FROM students ORDER BY name ASC";
    private static final String SQL_SELECT_BY_ID =
        "SELECT * FROM students WHERE id = ?";
    private static final String SQL_SEARCH_BY_NAME =
        "SELECT * FROM students WHERE name LIKE ?";
    private static final String SQL_UPDATE =
        "UPDATE students SET name=?, email=?, course=?, semester=?, cgpa=?, phone=? WHERE id=?";
    private static final String SQL_DELETE =
        "DELETE FROM students WHERE id = ?";
    private static final String SQL_COUNT =
        "SELECT COUNT(*) FROM students";

    // ── INSERT 
    @Override
    public boolean addStudent(Student student) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getCourse());
            ps.setInt(4, student.getSemester());
            ps.setDouble(5, student.getCgpa());
            ps.setString(6, student.getPhone());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("addStudent error: " + e.getMessage());
            return false;
        }
    }

    // ── SELECT ALL 
    @Override
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                students.add(mapRow(rs));
            }

        } catch (SQLException e) {
            System.err.println("getAllStudents error: " + e.getMessage());
        }
        return students;
    }

    // ── SELECT BY ID 
    @Override
    public Student getStudentById(int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("getStudentById error: " + e.getMessage());
        }
        return null;
    }

    // ── SEARCH BY NAME 
    @Override
    public List<Student> searchStudentsByName(String name) {
        List<Student> students = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SEARCH_BY_NAME)) {

            ps.setString(1, "%" + name + "%");  // partial match
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    students.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("searchStudentsByName error: " + e.getMessage());
        }
        return students;
    }

    // ── UPDATE
    @Override
    public boolean updateStudent(Student student) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getCourse());
            ps.setInt(4, student.getSemester());
            ps.setDouble(5, student.getCgpa());
            ps.setString(6, student.getPhone());
            ps.setInt(7, student.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("updateStudent error: " + e.getMessage());
            return false;
        }
    }

    // ── DELETE 
    @Override
    public boolean deleteStudent(int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("deleteStudent error: " + e.getMessage());
            return false;
        }
    }

    // ── COUNT 
    @Override
    public int getTotalCount() {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_COUNT);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("getTotalCount error: " + e.getMessage());
        }
        return 0;
    }

    private Student mapRow(ResultSet rs) throws SQLException {
        return new Student(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("email"),
            rs.getString("course"),
            rs.getInt("semester"),
            rs.getDouble("cgpa"),
            rs.getString("phone")
        );
    }
    
}
