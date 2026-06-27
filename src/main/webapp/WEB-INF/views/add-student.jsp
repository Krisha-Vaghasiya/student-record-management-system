<%-- 
    Document   : add-student
    Created on : 27 Jun 2026, 12:39:57 am
    Author     : krisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Student — SRMS</title>
    <title>Add Student — SRMS</title>
<style>
  :root { --navy:#1a2744; --blue:#2563eb; --gray-50:#f9fafb; --gray-200:#e5e7eb; --gray-600:#4b5563; --gray-800:#1f2937; --red:#dc2626; --radius:8px; }
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
  input, select { border:1px solid var(--gray-200); border-radius:var(--radius); padding:9px 12px; font-size:14px; color:var(--gray-800); width:100%; outline:none; }
  input:focus, select:focus { border-color:var(--blue); box-shadow:0 0 0 3px rgba(37,99,235,0.1); }
  .footer { display:flex; justify-content:flex-end; gap:8px; margin-top:1.5rem; }
  .btn { display:inline-flex; align-items:center; gap:6px; padding:9px 18px; border-radius:var(--radius); font-size:14px; font-weight:500; cursor:pointer; border:none; text-decoration:none; }
  .btn-primary { background:var(--blue); color:white; }
  .btn-ghost { background:white; color:var(--gray-600); border:1px solid var(--gray-200); }
</style>
</head>
<body>
<header class="header">
  <a href="students?action=list">← Back</a>
  <span>Add New Student</span>
</header>
<div class="container">
  <div class="card">
    <div class="card-title">Student Details</div>
    <form method="post" action="students">
      <input type="hidden" name="action" value="add">
      <div class="form-grid">
        <div class="form-group full">
          <label>Full Name *</label>
          <input type="text" name="name" required placeholder="e.g. Krisha Vaghasiya">
        </div>
        <div class="form-group">
          <label>Email *</label>
          <input type="email" name="email" required placeholder="student@email.com">
        </div>
        <div class="form-group">
          <label>Phone *</label>
          <input type="text" name="phone" required pattern="[0-9]{10}" placeholder="10-digit number">
        </div>
        <div class="form-group">
          <label>Course *</label>
          <select name="course" required>
            <option value="">Select course</option>
            <option value="MCA">MCA</option>
            <option value="BCA">BCA</option>
            <option value="BTECH">B.Tech</option>
            <option value="BE">BE</option>
          </select>
        </div>
        <div class="form-group">
          <label>Semester *</label>
          <select name="semester" required>
            <option value="">Select</option>
            <option>1</option><option>2</option><option>3</option><option>4</option>
            <option>5</option><option>6</option><option>7</option><option>8</option>
          </select>
        </div>
        <div class="form-group full">
          <label>CGPA (0.0 – 10.0) *</label>
          <input type="number" name="cgpa" required min="0" max="10" step="0.1" placeholder="e.g. 8.5">
        </div>
      </div>
      <div class="footer">
        <a class="btn btn-ghost" href="students?action=list">Cancel</a>
        <button class="btn btn-primary" type="submit">Add Student</button>
      </div>
    </form>
  </div>
</div>
</body>
</html>
