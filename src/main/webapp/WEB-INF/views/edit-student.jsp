<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Student — SRMS</title>
<style>
  :root { --navy:#1a2744; --blue:#2563eb; --gray-50:#f9fafb; --gray-200:#e5e7eb; --gray-600:#4b5563; --gray-800:#1f2937; --radius:8px; }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { font-family:'Segoe UI',system-ui,sans-serif; background:var(--gray-50); color:var(--gray-800); }
  .header { background:var(--navy); color:white; padding:0 2rem; display:flex; align-items:center; height:56px; gap:12px; font-weight:600; }
  .header a { color:rgba(255,255,255,0.6); text-decoration:none; font-weight:400; font-size:14px; }
  .container { max-width:560px; margin:2rem auto; padding:0 1rem; }
  .card { background:white; border-radius:12px; border:1px solid var(--gray-200); padding:2rem; }
  .card-title { font-size:18px; font-weight:600; color:var(--navy); margin-bottom:1.5rem; }
  .form-grid { display:grid; grid-template-columns:1fr 1fr; gap:1rem; }
  .form-group { display:flex; flex-direction:column; gap:5px; }
  .form-group.full { grid-column:1/-1; }
  label { font-size:13px; font-weight:500; color:var(--gray-600); }
  input, select { border:1px solid var(--gray-200); border-radius:var(--radius); padding:9px 12px; font-size:14px; color:var(--gray-800); width:100%; outline:none; background:white; }
  input:focus, select:focus { border-color:var(--blue); box-shadow:0 0 0 3px rgba(37,99,235,0.1); }
  select { appearance:none; -webkit-appearance:none; background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%234b5563' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E"); background-repeat:no-repeat; background-position:right 12px center; padding-right:36px; cursor:pointer; }
  .footer { display:flex; justify-content:flex-end; gap:8px; margin-top:1.5rem; }
  .btn { display:inline-flex; align-items:center; gap:6px; padding:9px 18px; border-radius:var(--radius); font-size:14px; font-weight:500; cursor:pointer; border:none; text-decoration:none; }
  .btn-primary { background:var(--blue); color:white; }
  .btn-ghost { background:white; color:var(--gray-600); border:1px solid var(--gray-200); }
</style>
</head>
<body>
<header class="header">
  <a href="students?action=list">← Back</a>
  <span>Edit Student</span>
</header>
<div class="container">
  <div class="card">
    <div class="card-title">Edit: ${student.name}</div>
    <form method="post" action="students">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="${student.id}">
      <div class="form-grid">
        <div class="form-group full">
          <label>Full Name *</label>
          <input type="text" name="name" required value="${student.name}">
        </div>
        <div class="form-group">
          <label>Email *</label>
          <input type="email" name="email" required value="${student.email}">
        </div>
        <div class="form-group">
          <label>Phone *</label>
          <input type="text" name="phone" required value="${student.phone}">
        </div>

        <%-- Course Dropdown --%>
        <div class="form-group">
          <label>Course *</label>
          <select name="course" required>
            <option value="" disabled>Select Course</option>
            <option value="MCA"   <c:if test="${student.course == 'MCA'}">selected</c:if>>MCA</option>
            <option value="BCA"   <c:if test="${student.course == 'BCA'}">selected</c:if>>BCA</option>
            <option value="BTECH" <c:if test="${student.course == 'BTECH'}">selected</c:if>>BTECH</option>
            <option value="BE"    <c:if test="${student.course == 'BE'}">selected</c:if>>BE</option>
          </select>
        </div>

        <%-- Semester Dropdown --%>
        <div class="form-group">
          <label>Semester *</label>
          <select name="semester" required>
            <option value="" disabled>Select Semester</option>
            <c:forEach begin="1" end="8" var="i">
              <option value="${i}" <c:if test="${student.semester == i}">selected</c:if>>
                Semester ${i}
              </option>
            </c:forEach>
          </select>
        </div>

        <div class="form-group full">
          <label>CGPA *</label>
          <input type="number" name="cgpa" required min="0" max="10" step="0.1" value="${student.cgpa}">
        </div>
      </div>
      <div class="footer">
        <a class="btn btn-ghost" href="students?action=list">Cancel</a>
        <button class="btn btn-primary" type="submit">Save Changes</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>