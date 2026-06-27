package com.srms.servlet;

import com.srms.dao.StudentDAO;
import com.srms.dao.StudentDAOImpl;
import com.srms.model.Student;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listStudents(req, resp);
                break;
            case "search":
                searchStudents(req, resp);
                break;
            case "showAdd":
                req.getRequestDispatcher("/WEB-INF/views/add-student.jsp").forward(req, resp);
                break;
            case "showEdit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteStudent(req, resp);
                break;
            default:
                listStudents(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addStudent(req, resp);
        } else if ("update".equals(action)) {
            updateStudent(req, resp);
        } else {
            listStudents(req, resp);
        }
    }

    private void listStudents(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        int totalCount = studentDAO.getTotalCount();
        req.setAttribute("students", students);
        req.setAttribute("totalCount", totalCount);
        req.getRequestDispatcher("/WEB-INF/views/student-list.jsp").forward(req, resp);
    }

    private void searchStudents(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Student> students = studentDAO.searchStudentsByName(query == null ? "" : query);
        req.setAttribute("students", students);
        req.setAttribute("searchQuery", query);
        req.setAttribute("totalCount", students.size());
        req.getRequestDispatcher("/WEB-INF/views/student-list.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/students?action=list");
            return;
        }
        req.setAttribute("student", student);
        req.getRequestDispatcher("/WEB-INF/views/edit-student.jsp").forward(req, resp);
    }

    private void addStudent(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Student student = extractStudentFromRequest(req);
        boolean success = studentDAO.addStudent(student);
        req.getSession().setAttribute("message",
            success ? "Student added successfully!" : "Failed to add student.");
        req.getSession().setAttribute("messageType", success ? "success" : "error");
        resp.sendRedirect(req.getContextPath() + "/students?action=list");
    }

    private void updateStudent(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Student student = extractStudentFromRequest(req);
        student.setId(Integer.parseInt(req.getParameter("id")));
        boolean success = studentDAO.updateStudent(student);
        req.getSession().setAttribute("message",
            success ? "Student updated successfully!" : "Failed to update student.");
        req.getSession().setAttribute("messageType", success ? "success" : "error");
        resp.sendRedirect(req.getContextPath() + "/students?action=list");
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = studentDAO.deleteStudent(id);
        req.getSession().setAttribute("message",
            success ? "Student deleted successfully!" : "Failed to delete student.");
        req.getSession().setAttribute("messageType", success ? "success" : "error");
        resp.sendRedirect(req.getContextPath() + "/students?action=list");
    }

    private Student extractStudentFromRequest(HttpServletRequest req) {
        String name  = req.getParameter("name").trim();
        String email = req.getParameter("email").trim();
        String course = req.getParameter("course").trim();
        int semester  = Integer.parseInt(req.getParameter("semester"));
        double cgpa   = Double.parseDouble(req.getParameter("cgpa"));
        String phone  = req.getParameter("phone").trim();
        return new Student(name, email, course, semester, cgpa, phone);
    }
}